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

variable "run_init_disk" {
  type        = bool
  default     = false
  description = "是否执行磁盘格式化操作"
}


variable "exclude_disk" {
  type        = map(list(string))
  default     = {}
  description = "生成排除命令片段, k8s-node01 │ sda|k8s-node01 │ sdc|k8s-node04 │ sdc"
}

variable "include_disk" {
  type        = map(string)
  default     = {}
  description = "生成包含命令片段，取valud值进行过滤，grep 3.6 | grep k8s-node01 请注意先后顺序"
}
