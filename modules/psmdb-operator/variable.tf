variable "enabled" {
  type        = bool
  default     = true
  description = "是否开启全局部署"
}

variable "pause" {
  type        = bool
  default     = false
  description = "是否优雅退出, 重启服务时会用到"
}

variable "namespace" {
  type        = string
  default     = "ps-mongo"
  description = "指定名称空间"
}

variable "psmdb_operator_version" {
  type        = string
  default     = "1.15.4"
  description = "PS Mongo Operator 使用的版本"
}

variable "psmdb_db_version" {
  type        = string
  default     = "1.15.3"
  description = "PS Mongo db 使用的版本"
}

variable "fullnameOverride" {
  type        = string
  default     = "prod"
  description = "全局名称"
}

variable "sharding_eanbled" {
  type        = bool
  default     = false
  description = "是否开启sharding cluster 模式部署"
}

variable "storageClass" {
  type        = string
  default     = "longhorn"
  description = "存储 Storage Class 使用的名称"
}

variable "storageSize" {
  type        = string
  default     = "15Gi"
  description = "申请存储空间大小"
}

variable "backup_enabled" {
  type        = bool
  default     = true
  description = "是否开启备份"
}

variable "backup_pitr_enabled" {
  type        = bool
  default     = true
  description = "是否开启 oplogs 实时备份"
}

variable "psmdb_db_resources" {
  type = map(any)
  default = {
    requests = {
      cpu    = "500m"
      memory = "0.7G"
    }
    limits = {
      cpu    = "500m"
      memory = "0.7G"
    }
  }
  description = "psmdb db 资源限制"
}

variable "bacckup_password" {
  type        = string
  default     = "lLns9YE88V1GvywJzTOv"
  sensitive   = true
  description = "备份恢复用户"
}

variable "database_admin_password" {
  type        = string
  default     = "3a3CkjMjvX2skgqWZAXI"
  sensitive   = true
  description = "数据库管理员用户"
}

variable "cluster_admin_password" {
  type        = string
  default     = "d1yeYMYjo1YlWZnwcP63"
  sensitive   = true
  description = "集群管理员"
}

variable "cluster_monitor_password" {
  type        = string
  default     = "UxqbotjiOXuxFWy3fxxB"
  sensitive   = true
  description = "集群监控"
}

variable "user_admin_password" {
  type        = string
  default     = "FDUGiEEZY6zCwWCYSuyV"
  sensitive   = true
  description = "用户管理"
}

variable "minio_backup_enabled" {
  type        = bool
  default     = true
  description = "是否开启 S3 备份, 将会创建桶"
}


variable "backup_minio_secret_name" {
  type        = string
  default     = "minio-secret"
  description = "备份 Minio Secret Name"
}

variable "backup_minio_api_access" {
  type        = string
  default     = "minio.minio.svc.cluster.local"
  description = "备份 Minio API 地址"
}

variable "backup_minio_policy_name" {
  type        = string
  default     = "psmdb-backup"
  description = "备份 Minio 使用的 Policy Name"
}

variable "backup_minio_access_key" {
  type        = string
  default     = "backup"
  sensitive   = true
  description = "备份使用 Minio Access Key"
}

variable "backup_minio_secret_key" {
  type        = string
  default     = "Qwe123456@@"
  sensitive   = true
  description = "备份使用 Minio Secret Key"
}


variable "backup_minio_bucket" {
  type = map(object({
    storageName = string
    bucket      = string
  }))
  default = {
    backup = {
      storageName = "s3-backups"
      bucket      = "mongo-backups"
    }
  }
  description = "备份 Minio 存储桶相关信息"
}
