resource "kubernetes_namespace" "nfs" {
  count = var.enabled ? 1 : 0
  metadata {
    name = var.namespace
  }
}

data "kubectl_path_documents" "docs" {
  pattern = "${path.module}/manifests/*.yaml"
  vars = {
    namespace      = var.namespace
    bind_node_name = var.bind_node_name
    bind_ip        = var.bind_ip
    bind_data_path = var.bind_data_path
    image_name     = var.image_name
  }
}

resource "kubectl_manifest" "nfs_deploy" {
  count      = var.enabled ? length(data.kubectl_path_documents.docs.documents) : 0
  depends_on = [kubernetes_namespace.nfs]
  yaml_body  = data.kubectl_path_documents.docs.documents[count.index]
}
