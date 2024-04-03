terraform {
  required_version = ">= 1.7.4"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.27.0"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = "2.0.4"
    }
  }
}
