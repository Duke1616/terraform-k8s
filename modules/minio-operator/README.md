# minio-operator

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.4 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.12.1 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.14.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.12.1 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.14.0 |

## Resources

| Name | Type |
|------|------|
| [helm_release.operator_deploy](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.tenant_deploy](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.minio_dashboard](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_path_documents.docs](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/path_documents) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enabled"></a> [enabled](#input\_enabled) | 是否开启全局部署 | `bool` | `true` | no |
| <a name="input_ingress_enabled"></a> [ingress\_enabled](#input\_ingress\_enabled) | 是否开启 Ingress 部署 | `bool` | `true` | no |
| <a name="input_minio_version"></a> [minio\_version](#input\_minio\_version) | Minio Operator 使用的版本 | `string` | `"5.0.14"` | no |
| <a name="input_operator_access_url"></a> [operator\_access\_url](#input\_operator\_access\_url) | Traefik 访问地址 | `string` | `"minio-operator.example.com"` | no |
| <a name="input_operator_namespace"></a> [operator\_namespace](#input\_operator\_namespace) | 指定名称空间 | `string` | `"minio-operator"` | no |
| <a name="input_operator_sts_enabled"></a> [operator\_sts\_enabled](#input\_operator\_sts\_enabled) | 是否开启 STS 认证 | `string` | `"off"` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | n/a | <pre>list(object({<br>    name             = string<br>    namespace        = string<br>    servers          = number<br>    volumesPerServer = number<br>    size             = string<br>    storageClassName = string<br>  }))</pre> | <pre>[<br>  {<br>    "name": "prod",<br>    "namespace": "minio",<br>    "servers": 4,<br>    "size": "10Gi",<br>    "storageClassName": "directpv-min-io",<br>    "volumesPerServer": 2<br>  }<br>]</pre> | no |
<!-- END_TF_DOCS -->
