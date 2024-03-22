variable "treafik_enabled" {
  type        = bool
  default     = true
  description = "是否开启 Traefik 部署"
}


variable "nfs_enabled" {
  type        = bool
  default     = true
  description = "是否开启 nfs-client-provisioner 部署"
}


variable "longhorn_enabled" {
  type        = bool
  default     = true
  description = "是否开启 Longhorn 部署"
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
