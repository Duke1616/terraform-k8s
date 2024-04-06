terraform {
  required_version = ">= 1.7.4"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.12.1"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = ">= 2.0.4"
    }
    minio = {
      source  = "aminueza/minio"
      version = ">= 2.2.0"
    }
  }
}
