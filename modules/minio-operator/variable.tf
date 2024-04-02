variable "enabled" {
  type        = bool
  default     = true
  description = "是否开启全局部署"
}

variable "ingress_enabled" {
  type        = bool
  default     = false
  description = "是否开启 Ingress 部署"
}

variable "operator_namespace" {
  type        = string
  default     = "minio-operator"
  description = "指定名称空间"
}

variable "minio_version" {
  type        = string
  default     = "5.0.14"
  description = "Minio Operator 使用的版本"
}

variable "operator_access_url" {
  type        = string
  default     = "minio-operator.example.com"
  description = "Minio Operator 访问地址"
}

variable "tenant_access_url" {
  type        = string
  default     = "example.com"
  description = "Minio Tenant 访问地址"
}

variable "operator_sts_enabled" {
  type        = string
  default     = "off"
  description = "是否开启 STS 认证"
}

variable "tenant" {
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
  default     = []
  description = "Minio Tenant 信息，可以同时创建多租户"
}
