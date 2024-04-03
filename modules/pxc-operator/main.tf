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
    templatefile("${path.module}/helm/manifests/backup.yaml.tpl", {
      namespace                = var.namespace
      backup_enabled           = var.backup_enabled
      backup_pitr_enabled      = var.backup_pitr_enabled
      backup_minio_api_access  = var.backup_minio_api_access
      backup_minio_secret_name = var.backup_minio_secret_name
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
