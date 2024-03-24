resource "helm_release" "k8tz_deploy" {
  count            = var.enabled ? 1 : 0
  name             = "k8tz"
  timeout          = 60
  chart            = "${path.module}/helm/charts/k8tz-${var.k8tz_version}.tgz"
  namespace        = var.namespace
  create_namespace = true
  values = [
    file("${path.module}/helm/values/values-${var.k8tz_version}.yaml")
  ]

  set {
    name  = "timezone"
    value = var.timezone
  }

  set {
    name  = "injectAll"
    value = var.injectAll
  }

  set {
    name  = "replicaCount"
    value = var.replicaCount
  }

  set {
    name  = "createNamespace"
    value = false
  }
}
