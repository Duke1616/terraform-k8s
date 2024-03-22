output "kubectl_manifest_count" {
  value = var.enabled ? length(data.kubectl_path_documents.docs.documents) : 0
}

output "kubectl_manifest_yaml" {
  value = var.enabled ? data.kubectl_path_documents.docs.documents : []
}
