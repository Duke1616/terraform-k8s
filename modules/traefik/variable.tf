variable "enabled" {
  type        = bool
  default     = true
  description = "是否开启全局部署"
}

variable "namespace" {
  type        = string
  default     = "traefik"
  description = "指定名称空间"
}

variable "traefik_version" {
  type        = string
  default     = "26.1.0"
  description = "Traefik 使用的版本"
}

variable "access_url" {
  type        = string
  default     = "traefik.example.com"
  description = "Traefik 访问地址"
}
