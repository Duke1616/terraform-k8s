variable "enabled" {
  type        = bool
  default     = true
  description = "是否开启全局部署"
}

variable "namespace" {
  type        = string
  default     = "k8tz"
  description = "指定名称空间"
}

variable "k8tz_version" {
  type        = string
  default     = "0.16.0"
  description = "K8TZ 使用的版本"
}

variable "timezone" {
  type        = string
  default     = "Asia/Shanghai"
  description = "设置容器时区"
}

variable "injectAll" {
  type        = bool
  default     = true
  description = "是否所有容器自动注入"
}

variable "replicaCount" {
  type        = number
  default     = 3
  description = "启动副本数量"
}
