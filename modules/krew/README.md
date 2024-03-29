# krew

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.4 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.5.1 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.2.2 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | >= 2.5.1 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 3.2.2 |

## Resources

| Name | Type |
|------|------|
| [local_file.krew_path](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.setup_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.setup_plugin](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enabled"></a> [enabled](#input\_enabled) | 是否开启全局部署 | `bool` | `true` | no |
| <a name="input_run_trigger"></a> [run\_trigger](#input\_run\_trigger) | always 则一直运行，filemd5 当引用文件发生变化时运行 | `string` | `"filemd5"` | no |
<!-- END_TF_DOCS -->
