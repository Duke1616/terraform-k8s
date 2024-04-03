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

provider "minio" {
  minio_server   = var.minio_server
  minio_region   = var.minio_region
  minio_user     = var.minio_access_key
  minio_password = var.minio_secret_key
}
