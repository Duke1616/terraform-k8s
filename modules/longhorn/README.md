# longhorn

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.4 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.12.1 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | 2.0.4 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.27.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.12.1 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | 1.14.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.27.0 |

## Resources

| Name | Type |
|------|------|
| [helm_release.longhorn_deploy](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.longhorn_dashboard](https://registry.terraform.io/providers/alekc/kubectl/2.0.4/docs/resources/manifest) | resource |
| [kubernetes_annotations.longhorn_annotation](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/annotations) | resource |
| [kubernetes_labels.longhorn_lables](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/labels) | resource |
| [kubectl_path_documents.longhorn](https://registry.terraform.io/providers/alekc/kubectl/2.0.4/docs/data-sources/path_documents) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_url"></a> [access\_url](#input\_access\_url) | longhorn 访问地址 | `string` | `"longhorn.example.com"` | no |
| <a name="input_allowVolumeCreationWithDegradedAvailability"></a> [allowVolumeCreationWithDegradedAvailability](#input\_allowVolumeCreationWithDegradedAvailability) | 生产环境建议关闭 | `bool` | `false` | no |
| <a name="input_backupTarget"></a> [backupTarget](#input\_backupTarget) | 用于备份的目标器。支持NFS和S3协议 | `string` | `"s3://longhorn@us-east-1/"` | no |
| <a name="input_backupTargetCredentialSecret"></a> [backupTargetCredentialSecret](#input\_backupTargetCredentialSecret) | 用于备份的 secret 凭证 | `string` | `"longhorn-s3-secret"` | no |
| <a name="input_createDefaultDiskLabeledNodes"></a> [createDefaultDiskLabeledNodes](#input\_createDefaultDiskLabeledNodes) | 只在带有标签的节点去部署服务 | `bool` | `true` | no |
| <a name="input_defaultDataPath"></a> [defaultDataPath](#input\_defaultDataPath) | 主机上数据存储的默认路径 | `string` | `"/data/longhorn"` | no |
| <a name="input_defaultFsType"></a> [defaultFsType](#input\_defaultFsType) | 根据磁盘类型，可选：xfs ext4 | `string` | `"ext4"` | no |
| <a name="input_defaultReplicaCount"></a> [defaultReplicaCount](#input\_defaultReplicaCount) | 从Longhorn用户界面创建卷时默认的副本数量，如果有大于3个节点选择3, 否则为2 | `number` | `2` | no |
| <a name="input_deletingConfirmationFlag"></a> [deletingConfirmationFlag](#input\_deletingConfirmationFlag) | 此处如何设置为 false， Longhorn将不允许卸载 | `bool` | `true` | no |
| <a name="input_dynamic_nodes"></a> [dynamic\_nodes](#input\_dynamic\_nodes) | 自定义 Longhorn 存储文件目录 | <pre>map(object({<br>    labels      = map(string)<br>    annotations = map(string)<br>  }))</pre> | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | 是否开启全局部署 | `bool` | `true` | no |
| <a name="input_ingress_enabled"></a> [ingress\_enabled](#input\_ingress\_enabled) | 是否开启 Ingress 部署 | `bool` | `true` | no |
| <a name="input_longhorn_version"></a> [longhorn\_version](#input\_longhorn\_version) | longhorn 使用的版本 | `string` | `"1.5.3"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | 名称空间 | `string` | `"longhorn-system"` | no |
| <a name="input_replicaSoftAntiAffinity"></a> [replicaSoftAntiAffinity](#input\_replicaSoftAntiAffinity) | 生产环境建议关闭 | `bool` | `false` | no |
| <a name="input_storageMinimalAvailablePercentage"></a> [storageMinimalAvailablePercentage](#input\_storageMinimalAvailablePercentage) | 如果最小可用磁盘容量超过可用磁盘容量的实际百分比，磁盘就会变得不可调度，直到释放出更多空间 | `number` | `20` | no |
| <a name="input_storageOverProvisioningPercentage"></a> [storageOverProvisioningPercentage](#input\_storageOverProvisioningPercentage) | 超额供应百分比，比如可以把200GB的volume调度到仅有100GB的存储节点上 | `number` | `200` | no |
| <a name="input_storageReservedPercentageForDefaultDisk"></a> [storageReservedPercentageForDefaultDisk](#input\_storageReservedPercentageForDefaultDisk) | 保留百分比指定不分配给每个新 Longhorn 节点上默认磁盘的磁盘空间百分比 | `number` | `15` | no |
| <a name="input_upgradeChecker"></a> [upgradeChecker](#input\_upgradeChecker) | 是否进行版本定期检查更新 | `bool` | `false` | no |
<!-- END_TF_DOCS -->
