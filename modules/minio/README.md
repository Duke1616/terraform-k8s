# minio

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.4 |
| <a name="requirement_minio"></a> [minio](#requirement\_minio) | >= 2.2.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_minio"></a> [minio](#provider\_minio) | >= 2.2.0 |

## Resources

| Name | Type |
|------|------|
| [minio_iam_policy.policy](https://registry.terraform.io/providers/aminueza/minio/latest/docs/resources/iam_policy) | resource |
| [minio_iam_user.user](https://registry.terraform.io/providers/aminueza/minio/latest/docs/resources/iam_user) | resource |
| [minio_iam_user_policy_attachment.iam](https://registry.terraform.io/providers/aminueza/minio/latest/docs/resources/iam_user_policy_attachment) | resource |
| [minio_s3_bucket.bucket](https://registry.terraform.io/providers/aminueza/minio/latest/docs/resources/s3_bucket) | resource |
| [minio_iam_policy_document.pocliy](https://registry.terraform.io/providers/aminueza/minio/latest/docs/data-sources/iam_policy_document) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enabled"></a> [enabled](#input\_enabled) | 是否开启模块 | `bool` | `false` | no |
| <a name="input_minio_access_key"></a> [minio\_access\_key](#input\_minio\_access\_key) | 创建用户 Minio Access Key | `string` | `""` | no |
| <a name="input_minio_bucket"></a> [minio\_bucket](#input\_minio\_bucket) | 需要创建存储桶列表 | `list(string)` | `[]` | no |
| <a name="input_minio_policy_name"></a> [minio\_policy\_name](#input\_minio\_policy\_name) | 创建 Policy 名称 | `string` | `""` | no |
| <a name="input_minio_secret_key"></a> [minio\_secret\_key](#input\_minio\_secret\_key) | 创建用户 Minio Secret Key | `string` | `""` | no |
<!-- END_TF_DOCS -->
