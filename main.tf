module "krew" {
  source  = "./modules/krew"
  enabled = var.krew_enabled
}

module "k8tz" {
  source  = "./modules/k8tz"
  enabled = var.k8tz_enabled
}

module "traefik" {
  depends_on = [module.k8tz]
  source     = "./modules/traefik"
  enabled    = var.treafik_enabled
  access_url = "traefik.${var.domain_uri}"
}

module "nfs-client-provisioner" {
  depends_on = [module.k8tz]
  source     = "./modules/nfs-client-provisioner"
  enabled    = var.nfs_enabled
}

module "longhorn" {
  depends_on      = [module.k8tz, module.traefik.helm_release]
  source          = "./modules/longhorn"
  enabled         = var.longhorn_enabled
  access_url      = "longhorn.${var.domain_uri}"
  ingress_enabled = var.treafik_enabled
  dynamic_nodes   = var.longhorn_dynamic_nodes
}

module "directpv" {
  depends_on    = [module.krew.null_resource]
  source        = "./modules/directpv"
  enabled       = var.directpv_enabled
  dynamic_nodes = var.directpv_dynamic_nodes
  exclude_disk  = var.directpv_exclude_disk
  include_disk  = var.directpv_include_disk
  run_init_disk = var.directpv_run_init_disk
}

module "minio-operator" {
  depends_on          = [module.k8tz, module.traefik.helm_release]
  source              = "./modules/minio-operator"
  enabled             = var.minio_enabled
  ingress_enabled     = var.treafik_enabled
  operator_access_url = "minio-operator.${var.domain_uri}"
  tenant_access_url   = var.domain_uri
  tenant              = var.minio_tenant
}

module "pxc-operator" {
  depends_on              = [module.k8tz, module.traefik.helm_release]
  source                  = "./modules/pxc-operator"
  pause                   = var.pxc_pause
  enabled                 = var.pxc_enabled
  backup_enabled          = var.pxc_backup_enabled
  minio_backup_enabled    = var.pxc_minio_backup_enabled
  backup_pitr_enabled     = var.pxc_backup_pitr_enabled
  backup_minio_api_access = var.pxc_backup_minio_api_access
}

module "psmdb-operator" {
  source                  = "./modules/psmdb-operator"
  enabled                 = var.psmdb_enabled
  pause                   = var.psmdb_pause
  backup_enabled          = var.psmdb_backup_enabled
  backup_pitr_enabled     = var.psmdb_backup_pitr_enabled
  minio_backup_enabled    = var.psmdb_minio_backup_enabled
  backup_minio_api_access = var.psmdb_backup_minio_api_access
}


module "kubeblocks" {
  source  = "./modules/kubeblocks"
  enabled = var.kubeblocks_enabled
}
