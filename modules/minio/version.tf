terraform {
  required_version = ">= 1.7.4"
  required_providers {
    minio = {
      source  = "aminueza/minio"
      version = ">= 2.2.0"
    }
  }
}
