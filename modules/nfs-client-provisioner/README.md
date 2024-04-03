# nfs-client-provisioner

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.4 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | 2.0.4 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.27.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | 1.14.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.27.0 |

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.nfs_deploy](https://registry.terraform.io/providers/alekc/kubectl/2.0.4/docs/resources/manifest) | resource |
| [kubernetes_namespace.nfs](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubectl_path_documents.docs](https://registry.terraform.io/providers/alekc/kubectl/2.0.4/docs/data-sources/path_documents) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bind_data_path"></a> [bind\_data\_path](#input\_bind\_data\_path) | NFS Server 数据挂载目录 | `string` | `"/data/nfs"` | no |
| <a name="input_bind_ip"></a> [bind\_ip](#input\_bind\_ip) | NFS Server 服务器IP地址 | `string` | `"192.168.80.140"` | no |
| <a name="input_bind_node_name"></a> [bind\_node\_name](#input\_bind\_node\_name) | 绑定 K8S Node 节点主机名 | `string` | `"k8s-node01"` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | 是否执行此模块 | `bool` | `true` | no |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | 镜像地址 | `string` | `"registry.cn-hangzhou.aliyuncs.com/smallsoup/nfs-subdir-external-provisioner:v4.0.2"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | 名称空间 | `string` | `"nfs"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kubectl_manifest_count"></a> [kubectl\_manifest\_count](#output\_kubectl\_manifest\_count) | n/a |
| <a name="output_kubectl_manifest_yaml"></a> [kubectl\_manifest\_yaml](#output\_kubectl\_manifest\_yaml) | n/a |
<!-- END_TF_DOCS -->
