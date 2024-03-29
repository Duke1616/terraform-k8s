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
  }
}
