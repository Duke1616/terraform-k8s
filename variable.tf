variable "domain_uri" {
  type        = string
  default     = "cdc.com"
  description = "服务域名 URI 地址"
}

variable "enable_debug_output" {
  type        = bool
  default     = false
  description = "DEBUG 类型的日志输出"
}

variable "enable_info_output" {
  type        = bool
  default     = false
  description = "INFO 类型的日志输出"
}

variable "krew_enabled" {
  type        = bool
  default     = true
  description = "是否开启 krew plugin 部署"
}

variable "k8tz_enabled" {
  type        = bool
  default     = false
  description = "是否开启 K8TZ 部署"
}

variable "treafik_enabled" {
  type        = bool
  default     = true
  description = "是否开启 Traefik 部署"
}

variable "nfs_enabled" {
  type        = bool
  default     = false
  description = "是否开启 nfs-client-provisioner 部署"
}

variable "longhorn_enabled" {
  type        = bool
  default     = true
  description = "是否开启 Longhorn 部署"
}

variable "longhorn_dynamic_nodes" {
  type = map(object({
    labels      = map(string)
    annotations = map(string)
  }))
  default = {
    "k8s-node01" = {
      annotations = {
        "node.longhorn.io/default-disks-config" = "[{\"path\":\"/data/longhorn\",\"allowScheduling\":true}]"
      }
      labels = {
        "node.longhorn.io/create-default-disk" = "config"
      }
    }
    "k8s-node02" = {
      annotations = {
        "node.longhorn.io/default-disks-config" = "[{\"path\":\"/data/longhorn\",\"allowScheduling\":true}]"
      }
      labels = {
        "node.longhorn.io/create-default-disk" = "config"
      }
    }
    "k8s-node03" = {
      annotations = {
        "node.longhorn.io/default-disks-config" = "[{\"path\":\"/data/longhorn\",\"allowScheduling\":true}]"
      }
      labels = {
        "node.longhorn.io/create-default-disk" = "config"
      }
    }
  }
  description = "自定义 Longhorn 存储文件目录"
}

variable "directpv_enabled" {
  type        = bool
  default     = true
  description = "是否开启 directpv 部署"
}

variable "directpv_dynamic_nodes" {
  type        = list(string)
  default     = ["k8s-node01", "k8s-node02", "k8s-node03", "k8s-node04"]
  description = "自定义 directpv 部署节点"
}

variable "directpv_run_init_disk" {
  type        = bool
  default     = false
  description = "是否部署后执行磁盘格式化操作"
}

variable "directpv_exclude_disk" {
  type = map(list(string))
  default = {
    "k8s-node01" = [
      "sdb",
    ]
    "k8s-node03" = [
      "sdc"
    ]
  }
  description = "生成排除命令片段, k8s-node01 │ sdb|k8s-node04 │ sdc"
}

variable "directpv_include_disk" {
  type = map(string)
  default = {
    size = 3.6
    # node = "k8s-node01"
  }
  description = "生成包含命令片段，取valud值进行过滤，grep 3.6 | grep k8s-node01 请注意先后顺序"
}

variable "minio_enabled" {
  type        = bool
  default     = true
  description = "是否开启 Minio 部署"
}

variable "minio_tenant" {
  type = list(object({
    name             = string
    namespace        = string
    servers          = number
    volumesPerServer = number
    size             = string
    storageClassName = string
    minio_access_key = string
    minio_secret_key = string
  }))
  default = [
    {
      name             = "prod"
      namespace        = "minio"
      servers          = 4
      volumesPerServer = 2
      size             = "10Gi"
      storageClassName = "directpv-min-io"
      minio_access_key = "u3E6KPj1zGIenHs8Pc58"
      minio_secret_key = "3qPIm47x2k01nzJypxA2OfvmDhgzslyA4JoPHnGP"
    }
  ]
  description = "Minio Tenant 创建租户"
}


variable "pxc_enabled" {
  type        = string
  default     = true
  description = "是否部署 Pxc Operator"
}

variable "pxc_backup_enabled" {
  type        = string
  default     = true
  description = "是否开启 PXC 备份, 暂只支持使用 Minio 进行存储"
}

variable "pxc_minio_backup_enabled" {
  type        = bool
  default     = true
  description = "是否开启 S3 备份, 将会创建桶"
}

variable "pxc_pause" {
  type        = bool
  default     = false
  description = "是否优雅退出, 重启服务时会用到"
}


variable "minio_server" {
  type        = string
  default     = "192.168.80.140:9001"
  description = "Minio Provider Host And Port"
}

variable "minio_access_key" {
  type        = string
  default     = "u3E6KPj1zGIenHs8Pc58"
  description = "Minio Provider Access Key"
}

variable "minio_secret_key" {
  type        = string
  default     = "3qPIm47x2k01nzJypxA2OfvmDhgzslyA4JoPHnGP"
  description = "Minio Provider Secret Key"
}

variable "minio_region" {
  type        = string
  default     = "us-east-1"
  description = "Minio Provider Region"
}
