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


resource "helm_release" "psmdb_db_deploy" {
  count            = var.enabled ? 1 : 0
  name             = "psmdb-db"
  timeout          = 500
  chart            = "${path.module}/helm/charts/psmdb-db-${var.psmdb_db_version}.tgz"
  namespace        = var.namespace
  create_namespace = true
  values = concat([
    file("${path.module}/helm/values/values-psmdb-db-${var.psmdb_db_version}.yaml"),

  ])

  dynamic "set" {
    for_each = {
      "fullnameOverride"                                      = var.fullnameOverride,
      "sharding.enabled"                                      = var.sharding_eanbled,
      "pause"                                                 = var.pause,
      "backup.enabled"                                        = var.backup_enabled
      "replsets[0].volumeSpec.pvc.storageClassName"           = var.storageClass
      "replsets[0].volumeSpec.pvc.resources.requests.storage" = var.storageSize
      "replsets[0].size"                                      = 3
      #"replsets[0].resources.limits.cpu" = var.psmdb_db_resources["limits"]["cpu"]
      #"replsets[0].resources.limits.memory" = var.psmdb_db_resources["limits"]["memory"]
      #"replsets[0].resources.requests.cpu" = var.psmdb_db_resources["requests"]["cpu"]
      #"replsets[0].resources.requests.memory" = var.psmdb_db_resources["requests"]["memory"]
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
