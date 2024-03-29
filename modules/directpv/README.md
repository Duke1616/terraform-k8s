# directpv
## 磁盘的格式化
格式化只作为第一次服务部署时的操作，后续扩容尽量采用人工干预的方式

### 方案 1
一般来讲我们需要通过 `directpv` 格式化的磁盘大小都是统一的，根据传递一个变量指定需要格式化的容量大小

生成可以格式化的磁盘文件 drives.yaml
```
kubectl directpv discover
```

### 方案 2
> 但是这样可能会存在，二次调用风险，导致格式化已经应用的磁盘

通过指定要格式化的磁盘，通过 `directpv` 直接进行格式化

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.4 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.14.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.27.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.2.2 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.14.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.27.0 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 3.2.2 |

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.directpv_deploy](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_labels.dircetpv_lables](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/labels) | resource |
| [null_resource.init_disk](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.setup_plugin](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [kubectl_path_documents.docs](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/path_documents) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dynamic_nodes"></a> [dynamic\_nodes](#input\_dynamic\_nodes) | 自定义 directpv 安裝节点名称 | `list(string)` | `[]` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | 是否开启全局部署 | `bool` | `true` | no |
| <a name="input_exclude_disk"></a> [exclude\_disk](#input\_exclude\_disk) | n/a | `map(list(string))` | <pre>{<br>  "k8s-node01": [<br>    "sda",<br>    "sdc"<br>  ],<br>  "k8s-node04": [<br>    "sdc"<br>  ]<br>}</pre> | no |
| <a name="input_include_disk"></a> [include\_disk](#input\_include\_disk) | 生成包含命令片段，取valud值进行过滤，grep 3.6 \| grep k8s-node01 请注意先后顺序 | `map(string)` | <pre>{<br>  "capacity": 3.6<br>}</pre> | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_grep_command"></a> [grep\_command](#output\_grep\_command) | n/a |
<!-- END_TF_DOCS -->
