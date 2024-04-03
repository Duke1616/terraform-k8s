variable "enabled" {
  type        = bool
  default     = true
  description = "是否开启全局部署"
}

variable "prevent_destroy" {
  type        = bool
  default     = true
  description = "设置为 true 不允许卸载应用"
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
          cpu    = "100m"
          memory = "512Mi"
        }
        limits = {
          memory = "512Mi"
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
