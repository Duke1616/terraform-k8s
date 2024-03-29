variable "enabled" {
  type        = bool
  default     = true
  description = "是否开启全局部署"
}

variable "dynamic_nodes" {
  type        = list(string)
  default     = []
  description = "自定义 directpv 安裝节点名称"
}
