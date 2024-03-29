output "nfs_manifest_yaml" {
  value = var.enable_debug_output ? module.nfs-client-provisioner.kubectl_manifest_yaml : null
}


output "traefik_url" {
  value = var.enable_info_output ? "traefik.example.com" : null
}


output "grep_command" {
  value = module.directpv.grep_command
}
