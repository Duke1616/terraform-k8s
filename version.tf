terraform {
  required_version = ">= 1.7.4"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = ">= 2.5.1"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.2"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.27.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.12.1"
    }
  }
}
