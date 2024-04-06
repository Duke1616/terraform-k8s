output "nfs_manifest_yaml" {
  value = var.enable_debug_output ? module.nfs-client-provisioner.kubectl_manifest_yaml : null
}

output "traefik_url" {
  value = var.enable_info_output ? "traefik.example.com" : null
}

output "directpv_grep_include" {
  value = module.directpv.grep_include
}

output "directpv_grep_exclude" {
  value = module.directpv.grep_exclude
}

output "minio_server" {
  value = module.minio-operator.minio_server
}
