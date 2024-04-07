variable "enabled" {
  type        = bool
  default     = false
  description = "是否开启模块"
}

variable "minio_bucket" {
  type        = list(string)
  default     = []
  description = "需要创建存储桶列表"
}

variable "minio_policy_name" {
  type        = string
  default     = ""
  description = "创建 Policy 名称"
}

variable "minio_access_key" {
  type        = string
  default     = ""
  sensitive   = true
  description = "创建用户 Minio Access Key"
}

variable "minio_secret_key" {
  type        = string
  default     = ""
  sensitive   = true
  description = "创建用户 Minio Secret Key"
}
