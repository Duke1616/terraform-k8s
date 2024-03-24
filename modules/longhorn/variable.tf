variable "enabled" {
  type        = bool
  default     = true
  description = "是否开启全局部署"
}

variable "namespace" {
  type        = string
  default     = "longhorn-system"
  description = "名称空间"
}

variable "longhorn_version" {
  type        = string
  default     = "1.5.3"
  description = "longhorn 使用的版本"
}

variable "access_url" {
  type        = string
  default     = "longhorn.example.com"
  description = "longhorn 访问地址"
}

variable "dynamic_nodes" {
  type = map(object({
    labels      = map(string)
    annotations = map(string)
  }))
  default     = {}
  description = "自定义 Longhorn 存储文件目录"
}

variable "defaultFsType" {
  type        = string
  default     = "xfs"
  description = "根据磁盘类型，可选：xfs ext4"
}


variable "backupTarget" {
  type        = string
  default     = "s3://longhorn@us-east-1/"
  description = "用于备份的目标器。支持NFS和S3协议"
}

variable "backupTargetCredentialSecret" {
  type        = string
  default     = "longhorn-s3-secret"
  description = "用于备份的 secret 凭证"
}

variable "createDefaultDiskLabeledNodes" {
  type        = bool
  default     = true
  description = "只在带有标签的节点去部署服务"
}

variable "defaultDataPath" {
  type        = string
  default     = "/data/longhorn"
  description = "主机上数据存储的默认路径"
}

variable "defaultReplicaCount" {
  type        = number
  default     = 2
  description = "从Longhorn用户界面创建卷时默认的副本数量，如果有大于3个节点选择3, 否则为2"
}

variable "upgradeChecker" {
  type        = bool
  default     = false
  description = "是否进行版本定期检查更新"
}

variable "replicaSoftAntiAffinity" {
  type        = bool
  default     = false
  description = "生产环境建议关闭"
}

variable "allowVolumeCreationWithDegradedAvailability" {
  type        = bool
  default     = false
  description = "生产环境建议关闭"
}

variable "storageOverProvisioningPercentage" {
  type        = number
  default     = 200
  description = "超额供应百分比，比如可以把200GB的volume调度到仅有100GB的存储节点上"
}

variable "storageMinimalAvailablePercentage" {
  type        = number
  default     = 20
  description = "如果最小可用磁盘容量超过可用磁盘容量的实际百分比，磁盘就会变得不可调度，直到释放出更多空间"
}

variable "storageReservedPercentageForDefaultDisk" {
  type        = number
  default     = 15
  description = "保留百分比指定不分配给每个新 Longhorn 节点上默认磁盘的磁盘空间百分比"
}

variable "deletingConfirmationFlag" {
  type        = bool
  default     = true
  description = "此处如何设置为 false， Longhorn将不允许卸载"
}
