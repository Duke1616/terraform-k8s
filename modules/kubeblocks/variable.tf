variable "enabled" {
  type        = bool
  default     = true
  description = "是否开启全局部署"
}


variable "namespace" {
  type        = string
  default     = "kubeblocks"
  description = "指定名称空间"
}


variable "chart_version" {
  type        = string
  default     = "0.8.2"
  description = "kubeblocks Helm Chart 使用的版本"
}
