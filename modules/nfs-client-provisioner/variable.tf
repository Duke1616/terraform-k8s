variable "enabled" {
  type        = bool
  default     = true
  description = "是否执行此模块"
}

variable "namespace" {
  type        = string
  default     = "nfs"
  description = "名称空间"
}

variable "image_name" {
  type        = string
  default     = "registry.cn-hangzhou.aliyuncs.com/smallsoup/nfs-subdir-external-provisioner:v4.0.2"
  description = "镜像地址"
}

variable "bind_node_name" {
  type        = string
  default     = "k8s-node01"
  description = "绑定 K8S Node 节点主机名"
}

variable "bind_ip" {
  type        = string
  default     = "192.168.80.140"
  description = "NFS Server 服务器IP地址"
}

variable "bind_data_path" {
  type        = string
  default     = "/data/nfs"
  description = "NFS Server 数据挂载目录"
}
