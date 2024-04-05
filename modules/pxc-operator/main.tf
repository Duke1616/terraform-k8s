locals {
  is_limits_empty = length(keys(var.pxc_resources["pxc"]["resources"]["limits"])) == 0
  has_memory      = contains(keys(var.pxc_resources["pxc"]["resources"]["limits"]), "memory")
  # https://docs.percona.com/percona-operator-for-mysql/pxc/options.html#make-changed-options-visible-to-percona-xtradb-cluster
  # 如果开启 limits 限制，PXC会自动调节 innodb_buffer_pool_size
  innodb_buffer_pool_size = local.is_limits_empty ? var.innodb_buffer_pool_size : (local.has_memory ? "system_define" : var.innodb_buffer_pool_size)
}

resource "helm_release" "pxc_operator_deploy" {
  count            = var.enabled ? 1 : 0
  name             = "pxc-operator"
  timeout          = 60
  chart            = "${path.module}/helm/charts/pxc-operator-${var.pxc_version}.tgz"
  namespace        = var.namespace
  create_namespace = true
  values = [
    file("${path.module}/helm/values/values-pxc-operator-${var.pxc_version}.yaml")
  ]

  lifecycle {
    prevent_destroy = false
  }
}

data "kubectl_path_documents" "pxc_operator" {
  pattern = "${path.module}/manifests/secret*.yaml"
  vars = {
    namespace                = var.namespace
    backup_minio_secret_name = var.backup_minio_secret_name
    backup_minio_access_key  = base64encode(var.backup_minio_access_key)
    backup_minio_secret_key  = base64encode(var.backup_minio_secret_key)
  }
}

resource "kubectl_manifest" "pxc_operator" {
  depends_on = [helm_release.pxc_operator_deploy]
  count      = var.enabled ? length(data.kubectl_path_documents.pxc_operator.documents) : 0
  yaml_body  = data.kubectl_path_documents.pxc_operator.documents[count.index]
}


resource "helm_release" "pxc_db_deploy" {
  depends_on       = [kubectl_manifest.pxc_operator]
  count            = var.enabled ? 1 : 0
  name             = "pxc-db"
  timeout          = 500
  chart            = "${path.module}/helm/charts/pxc-db-${var.pxc_version}.tgz"
  namespace        = var.namespace
  create_namespace = true
  values = [
    file("${path.module}/helm/values/values-pxc-db-${var.pxc_version}.yaml"),
    templatefile("${path.module}/helm/manifests/configuration.yaml.tpl", {
      innodb_buffer_pool_size      = local.innodb_buffer_pool_size
      max_connections              = var.max_connections
      innodb_buffer_pool_instances = var.innodb_buffer_pool_instances
    }),
    templatefile("${path.module}/helm/manifests/secret.yaml.tpl", {
      root_password         = var.root_password
      xtrabackup_password   = var.xtrabackup_password
      monitor_password      = var.monitor_password
      clustercheck_password = var.clustercheck_password
      proxyadmin_password   = var.proxyadmin_password
      operator_password     = var.operator_password
      replication_password  = var.replication_password
    }),
    templatefile("${path.module}/helm/manifests/backup.yaml.tpl", {
      namespace                = var.namespace
      backup_enabled           = var.backup_enabled
      backup_pitr_enabled      = var.backup_pitr_enabled
      backup_minio_api_access  = var.backup_minio_api_access
      backup_minio_secret_name = var.backup_minio_secret_name
      backup_minio_bucket_json = jsonencode(tomap({ minio = var.backup_minio_bucket }))
    }),
    yamlencode(var.pxc_resources),
    yamlencode(var.haproxy_resources),
    yamlencode(var.logcollector_resources),
    yamlencode(var.backup_pitr_resources)
  ]

  dynamic "set" {
    for_each = {
      "fullnameOverride"             = var.fullnameOverride,
      "pxc.persistence.storageClass" = var.storageClass,
      "pxc.persistence.size"         = var.storageSize,
      "pxc.disableTLS"               = var.disableTLS,
      "pause"                        = var.pause,
    }
    content {
      name  = set.key
      value = set.value
    }
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "minio_s3_bucket" "pxc_bucket" {
  for_each      = var.minio_backup_enabled ? var.backup_minio_bucket : {}
  bucket        = each.value.bucket
  force_destroy = false
  acl           = "private"

  lifecycle {
    prevent_destroy = false
  }
}

data "minio_iam_policy_document" "pxc_policy" {
  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      for key, value in var.backup_minio_bucket : "arn:aws:s3:::${value.bucket}/*"
    ]
  }
}

resource "minio_iam_policy" "pxc_pocliy" {
  count  = var.minio_backup_enabled ? 1 : 0
  name   = "pxc-backup"
  policy = data.minio_iam_policy_document.pxc_policy.json
}


resource "minio_iam_user" "pxc_user" {
  count         = var.minio_backup_enabled ? 1 : 0
  name          = var.backup_minio_access_key
  force_destroy = false
  secret        = var.backup_minio_secret_key
}


resource "minio_iam_user_policy_attachment" "pxc_iam" {
  count       = var.minio_backup_enabled ? 1 : 0
  user_name   = minio_iam_user.pxc_user[count.index].id
  policy_name = minio_iam_policy.pxc_pocliy[count.index].id
}
