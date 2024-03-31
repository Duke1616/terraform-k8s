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


variable "exclude_disk" {
  type    = map(list(string))
  default = {}
}

variable "include_disk" {
  type = map(string)
  default = {
    # capacity = 3.6
    # node = "k8s-node01"
  }
  description = "生成包含命令片段，取valud值进行过滤，grep 3.6 | grep k8s-node01 请注意先后顺序"
}
