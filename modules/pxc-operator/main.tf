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

  dynamic "set_sensitive" {
    for_each = {
      "secret.passwords.root"         = var.root_password
      "secret.passwords.xtrabackup"   = var.xtrabackup_password
      "secret.passwords.monitor"      = var.monitor_password
      "secret.passwords.clustercheck" = var.clustercheck_password
      "secret.passwords.proxyadmin"   = var.proxyadmin_password
      "secret.passwords.operator"     = var.operator_password
      "secret.passwords.replication"  = var.replication_password
    }
    content {
      name  = set_sensitive.key
      value = set_sensitive.value
    }
  }

  lifecycle {
    prevent_destroy = false
  }
}

module "pxc-minio" {
  source            = "../minio"
  enabled           = var.minio_backup_enabled
  minio_policy_name = var.backup_minio_policy_name
  minio_bucket      = [for b in values(var.backup_minio_bucket) : b.bucket]
  minio_access_key  = var.backup_minio_access_key
  minio_secret_key  = var.backup_minio_secret_key
}
