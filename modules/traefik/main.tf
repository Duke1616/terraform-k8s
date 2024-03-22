provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "traefik_deploy" {
  count            = var.enabled ? 1 : 0
  name             = "traefik"
  timeout          = 60
  chart            = "${path.module}/helm/charts/traefik-${var.traefik_version}.tgz"
  namespace        = var.namespace
  create_namespace = true
  values = [
    file("${path.module}/helm/values/values-${var.traefik_version}.yaml")
  ]
}
