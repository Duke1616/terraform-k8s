provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "kubernetes_namespace" "traefik" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "traefik_deploy" {
  depends_on = [kubernetes_namespace.traefik]
  name       = "traefik"
  timeout    = 60
  chart      = "./helm/charts/traefik-${var.helm_traefik_version}.tgz"
  namespace  = var.namespace
  values = [
    file("${path.module}/helm/values/values-${var.helm_traefik_version}.yaml")
  ]
}
