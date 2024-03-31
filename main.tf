provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubectl" {
  config_path = "~/.kube/config"
}

module "krew" {
  source  = "./modules/krew"
  enabled = var.krew_enabled
}

module "k8tz" {
  source  = "./modules/k8tz"
  enabled = var.k8tz_enabled
}

module "traefik" {
  source     = "./modules/traefik"
  enabled    = var.treafik_enabled
  access_url = "traefik.${var.domain_uri}"
}

module "nfs-client-provisioner" {
  source  = "./modules/nfs-client-provisioner"
  enabled = var.nfs_enabled
}

module "longhorn" {
  source        = "./modules/longhorn"
  enabled       = var.longhorn_enabled
  access_url    = "longhorn.${var.domain_uri}"
  dynamic_nodes = var.longhorn_dynamic_nodes
}

module "directpv" {
  source        = "./modules/directpv"
  enabled       = var.directpv_enabled
  dynamic_nodes = var.directpv_dynamic_nodes
  exclude_disk  = var.directpv_exclude_disk
  include_disk  = var.directpv_include_disk
  run_init_disk = var.directpv_run_init_disk
}
