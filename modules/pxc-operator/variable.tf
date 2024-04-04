variable "enabled" {
  type        = bool
  default     = true
  description = "是否开启全局部署"
}

variable "pause" {
  type        = bool
  default     = false
  description = "是否优雅退出, 重启服务时会用到"
}

variable "namespace" {
  type        = string
  default     = "pxc-mysql"
  description = "指定名称空间"
}

variable "pxc_version" {
  type        = string
  default     = "1.14.0"
  description = "PXC Operator 使用的版本"
}

variable "fullnameOverride" {
  type        = string
  default     = "prod"
  description = "全局名称"
}

variable "storageClass" {
  type        = string
  default     = "longhorn"
  description = "存储 Storage Class 使用的名称"
}

variable "storageSize" {
  type        = string
  default     = "10Gi"
  description = "申请存储空间大小"
}

variable "backup_enabled" {
  type        = bool
  default     = false
  description = "是否开启备份"
}

variable "backup_pitr_enabled" {
  type        = bool
  default     = false
  description = "是否开启 binlogs 实时备份"
}

variable "minio_backup_enabled" {
  type        = bool
  default     = true
  description = "是否开启 S3 备份, 将会创建桶"
}

variable "backup_minio_secret_name" {
  type        = string
  default     = "minio-secret"
  description = "备份 Minio Secret Name"
}

variable "backup_minio_api_access" {
  type        = string
  default     = "minio.minio.svc.cluster.local"
  description = "备份 Minio 地址"
}

variable "backup_minio_access_key" {
  type        = string
  default     = "backup"
  sensitive   = true
  description = "备份使用 Minio Access Key"
}

variable "backup_minio_secret_key" {
  type        = string
  default     = "Qwe123456@@"
  sensitive   = true
  description = "备份使用 Minio Secret Key"
}


variable "backup_minio_bucket" {
  type = map(object({
    storageName = string
    bucket      = string
  }))
  default = {
    backup = {
      storageName = "s3-backups"
      bucket      = "mysql-backups"
    },
    pitr = {
      storageName = "s3-binlogs"
      bucket      = "mysql-binlogs"
    }
  }
  description = "备份 Minio 存储桶相关信息"
}

variable "disableTLS" {
  type        = bool
  default     = true
  description = "创建群集时是否关闭 TLS"
}

variable "pxc_resources" {
  type = map(any)
  default = {
    pxc = {
      resources = {
        requests = {
          cpu    = "600m"
          memory = "1Gi"
        }
        limits = {}
      }
    }
  }
  description = "PXC 资源限制"
}

variable "haproxy_resources" {
  type = map(any)
  default = {
    haproxy = {
      resources = {
        requests = {
          cpu    = "600m"
          memory = "0.5G"
        }
        limits = {}
      }
    }
  }
  description = "Haproxy 资源限制"
}

variable "logcollector_resources" {
  type = map(any)
  default = {
    logcollector = {
      resources = {
        requests = {
          cpu    = "200m"
          memory = "100M"
        }
        limits = {}
      }
    }
  }
  description = "Logcollertor 资源限制"
}

variable "backup_pitr_resources" {
  type = map(any)
  default = {
    backup = {
      pitr = {
        resources = {
          requests = {}
          limits   = {}
        }
      }
    }
  }
  description = "Backup Pitr 资源限制"
}
