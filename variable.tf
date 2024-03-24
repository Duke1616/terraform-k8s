
variable "domain_uri" {
  type        = string
  default     = "cdc.com"
  description = "服务域名 URI 地址"
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
