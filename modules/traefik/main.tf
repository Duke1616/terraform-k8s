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

data "kubectl_path_documents" "docs" {
  pattern = "${path.module}/manifests/*.yaml"
  vars = {
    namespace  = var.namespace
    access_url = var.access_url
  }
}

resource "kubectl_manifest" "traefik_dashboard" {
  count     = var.enabled ? length(data.kubectl_path_documents.docs.documents) : 0
  yaml_body = data.kubectl_path_documents.docs.documents[count.index]
}
