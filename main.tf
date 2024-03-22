module "traefik" {
  source  = "./modules/traefik"
  enabled = var.treafik_enabled
}

module "nfs-client-provisioner" {
  source  = "./modules/nfs-client-provisioner"
  enabled = var.nfs_enabled
}

module "longhorn" {
  source  = "./modules/longhorn"
  enabled = var.longhorn_enabled
}
