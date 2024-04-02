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
