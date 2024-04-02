resource "helm_release" "operator_deploy" {
  count            = var.enabled ? 1 : 0
  name             = "minio-operator"
  timeout          = 60
  chart            = "${path.module}/helm/charts/operator-${var.minio_version}.tgz"
  namespace        = var.operator_namespace
  create_namespace = true
  values = [
    file("${path.module}/helm/values/values-operator-${var.minio_version}.yaml")
  ]

  set {
    name  = "operator.env[0].value"
    value = var.operator_sts_enabled
  }
}

resource "helm_release" "tenant_deploy" {
  depends_on       = [helm_release.operator_deploy]
  for_each         = var.enabled ? { for idx, tenant in var.tenant : idx => tenant } : {}
  name             = "minio-tenant"
  timeout          = 120
  chart            = "${path.module}/helm/charts/tenant-${var.minio_version}.tgz"
  namespace        = each.value.namespace
  create_namespace = true
  values = [
    file("${path.module}/helm/values/values-tenant-${var.minio_version}.yaml")
  ]

  dynamic "set" {
    for_each = {
      "tenant.name"                        = each.value.name
      "tenant.pools[0].servers"            = each.value.servers
      "tenant.pools[0].volumesPerServer"   = each.value.volumesPerServer
      "tenant.pools[0].size"               = each.value.size
      "tenant.pools[0].storageClassName"   = each.value.storageClassName
      "tenant.certificate.requestAutoCert" = false
      "secrets.accessKey"                  = each.value.minio_access_key
      "secrets.secretKey"                  = each.value.minio_secret_key
    }
    content {
      name  = set.key
      value = set.value
    }
  }
}

data "kubectl_path_documents" "minio" {
  pattern = "${path.module}/manifests/*.yaml"
  vars = {
    operator_namespace  = var.operator_namespace
    operator_access_url = var.operator_access_url
    tenant_access_url   = var.tenant_access_url
    tenant_resources    = jsonencode(var.tenant)
  }
}

resource "kubectl_manifest" "minio_dashboard" {
  depends_on = [helm_release.tenant_deploy]
  count      = var.ingress_enabled && var.enabled ? length(data.kubectl_path_documents.minio.documents) : 0
  yaml_body  = data.kubectl_path_documents.minio.documents[count.index]
}
