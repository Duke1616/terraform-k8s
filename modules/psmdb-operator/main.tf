resource "helm_release" "psmdb_operator_deploy" {
  count            = var.enabled ? 1 : 0
  name             = "psmdb-operator"
  timeout          = 120
  chart            = "${path.module}/helm/charts/psmdb-operator-${var.psmdb_operator_version}.tgz"
  namespace        = var.namespace
  create_namespace = true
  values = [
    file("${path.module}/helm/values/values-psmdb-operator-${var.psmdb_operator_version}.yaml")
  ]

  set {
    name  = "disableTelemetry"
    value = true
  }

  lifecycle {
    prevent_destroy = false
  }
}

data "kubectl_path_documents" "psmdb_operator" {
  pattern = "${path.module}/manifests/secret*.yaml"
  vars = {
    namespace                = var.namespace
    backup_minio_secret_name = var.backup_minio_secret_name
    backup_minio_access_key  = base64encode(var.backup_minio_access_key)
    backup_minio_secret_key  = base64encode(var.backup_minio_secret_key)
  }
}

resource "kubectl_manifest" "psmdb_operator" {
  depends_on = [helm_release.psmdb_operator_deploy]
  count      = var.enabled ? length(data.kubectl_path_documents.psmdb_operator.documents) : 0
  yaml_body  = data.kubectl_path_documents.psmdb_operator.documents[count.index]
}


resource "helm_release" "psmdb_db_deploy" {
  count            = var.enabled ? 1 : 0
  name             = "psmdb-db"
  timeout          = 500
  chart            = "${path.module}/helm/charts/psmdb-db-${var.psmdb_db_version}.tgz"
  namespace        = var.namespace
  create_namespace = true
  values = [
    file("${path.module}/helm/values/values-psmdb-db-${var.psmdb_db_version}.yaml"),
    templatefile("${path.module}/helm/manifests/backup.yaml.tpl", {
      backup_enabled           = var.backup_enabled
      backup_pitr_enabled      = var.backup_pitr_enabled
      backup_minio_api_access  = var.backup_minio_api_access
      backup_minio_secret_name = var.backup_minio_secret_name
      backup_minio_bucket_json = jsonencode(tomap({ minio = var.backup_minio_bucket }))
    }),
  ]

  dynamic "set" {
    for_each = {
      "fullnameOverride"                                      = var.fullnameOverride,
      "sharding.enabled"                                      = var.sharding_eanbled,
      "pause"                                                 = var.pause,
      "backup.enabled"                                        = var.backup_enabled
      "replsets[0].volumeSpec.pvc.storageClassName"           = var.storageClass
      "replsets[0].volumeSpec.pvc.resources.requests.storage" = var.storageSize
      "replsets[0].size"                                      = 3
      "replsets[0].resources.limits.cpu"                      = var.psmdb_db_resources["limits"]["cpu"]
      "replsets[0].resources.limits.memory"                   = var.psmdb_db_resources["limits"]["memory"]
      "replsets[0].resources.requests.cpu"                    = var.psmdb_db_resources["requests"]["cpu"]
      "replsets[0].resources.requests.memory"                 = var.psmdb_db_resources["requests"]["memory"]
    }
    content {
      name  = set.key
      value = set.value
    }
  }


  dynamic "set_sensitive" {
    for_each = {
      "users.MONGODB_BACKUP_PASSWORD"          = var.bacckup_password
      "users.MONGODB_DATABASE_ADMIN_PASSWORD"  = var.database_admin_password
      "users.MONGODB_CLUSTER_ADMIN_PASSWORD"   = var.cluster_admin_password
      "users.MONGODB_CLUSTER_MONITOR_PASSWORD" = var.cluster_monitor_password
      "users.MONGODB_USER_ADMIN_PASSWORD"      = var.user_admin_password
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

module "psmdb-minio" {
  source            = "../minio"
  enabled           = var.minio_backup_enabled
  minio_policy_name = var.backup_minio_policy_name
  minio_bucket      = [for b in values(var.backup_minio_bucket) : b.bucket]
  minio_access_key  = var.backup_minio_access_key
  minio_secret_key  = var.backup_minio_secret_key
}
