output "minio_server" {
  value = {
    for tenant_key, tenant in var.tenant : tenant.name => {
      api = "minio.${tenant.namespace}.svc.cluster.local"
      web = "http://minio-${tenant.name}.${var.tenant_access_url}"
    }
  }
}
