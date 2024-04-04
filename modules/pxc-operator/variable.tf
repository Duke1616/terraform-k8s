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
        limits = {
          memory = "8Gi"
        }
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


variable "root_password" {
  type      = string
  default   = "YnPdcu9qr9hnWqBT5quO"
  sensitive = true
}

variable "xtrabackup_password" {
  type      = string
  default   = "TPkuN4XRjOmWpLkeJfrj"
  sensitive = true
}

variable "monitor_password" {
  type      = string
  default   = "p0Y2Slwy64keski4FyRA"
  sensitive = true
}

variable "clustercheck_password" {
  type      = string
  default   = "YNElyPmLQSaqPEP4Yrwn"
  sensitive = true
}

variable "proxyadmin_password" {
  type      = string
  default   = "BCrfhLNRqSvvAho2pn0s"
  sensitive = true
}

variable "operator_password" {
  type      = string
  default   = "VBjqJwiQ5FL5sYE6QCEG"
  sensitive = true
}

variable "replication_password" {
  type      = string
  default   = "vhMSUhvEMa4bufYjhFvv"
  sensitive = true
}

variable "innodb_buffer_pool_size" {
  type        = string
  default     = "2G"
  description = "官方推荐其配置为系统内存的 50% 到 75%"
}

variable "max_connections" {
  type        = number
  default     = 5000
  description = "最大连接数"
}

variable "innodb_buffer_pool_instances" {
  type        = number
  default     = 4
  description = "该参数可以设置为服务器 CPU 核心数，这样可在一定程度上提供并发性能"
}
