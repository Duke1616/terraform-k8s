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
  source  = "./modules/nfs-client-provisioner"
  enabled = var.nfs_enabled
}

module "longhorn" {
  depends_on    = [module.k8tz]
  source        = "./modules/longhorn"
  enabled       = var.longhorn_enabled
  access_url    = "longhorn.${var.domain_uri}"
  dynamic_nodes = var.longhorn_dynamic_nodes
}
