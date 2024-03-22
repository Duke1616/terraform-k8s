# traefik

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.7.4 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.12.1 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.12.1 |

## Resources

| Name | Type |
|------|------|
| [helm_release.traefik_deploy](https://registry.terraform.io/providers/hashicorp/helm/2.12.1/docs/resources/release) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enabled"></a> [enabled](#input\_enabled) | 是否开启全局部署 | `bool` | `true` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | 指定名称空间 | `string` | `"traefik"` | no |
| <a name="input_traefik_version"></a> [traefik\_version](#input\_traefik\_version) | Traefik 使用的版本 | `string` | `"26.1.0"` | no |
<!-- END_TF_DOCS -->
