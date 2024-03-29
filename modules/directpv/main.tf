resource "kubernetes_labels" "dircetpv_lables" {
  for_each    = var.enabled ? zipmap(var.dynamic_nodes, var.dynamic_nodes) : {}
  api_version = "v1"
  kind        = "Node"
  metadata {
    name = each.key
  }
  field_manager = "dircetpvLabels"
  labels = {
    "directpv.min.io/enabled" = "true"
  }
}

data "kubectl_path_documents" "docs" {
  pattern = "${path.module}/manifests/*.yaml"
}

resource "kubectl_manifest" "directpv_deploy" {
  count     = var.enabled ? length(data.kubectl_path_documents.docs.documents) : 0
  yaml_body = data.kubectl_path_documents.docs.documents[count.index]
}
