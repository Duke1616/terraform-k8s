# directpv

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
## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.14.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.27.0 |

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.directpv_deploy](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_labels.dircetpv_lables](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/labels) | resource |
| [kubectl_path_documents.docs](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/path_documents) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dynamic_nodes"></a> [dynamic\_nodes](#input\_dynamic\_nodes) | 自定义 directpv 安裝节点名称 | `list(string)` | `[]` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | 是否开启全局部署 | `bool` | `true` | no |
<!-- END_TF_DOCS -->
