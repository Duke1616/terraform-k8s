# pxc-operator

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
| <a name="requirement_minio"></a> [minio](#requirement\_minio) | >= 2.2.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.12.1 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | 2.0.4 |
| <a name="provider_minio"></a> [minio](#provider\_minio) | >= 2.2.0 |

## Resources

| Name | Type |
|------|------|
| [helm_release.pxc_db_deploy](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.pxc_operator_deploy](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.pxc_operator](https://registry.terraform.io/providers/alekc/kubectl/2.0.4/docs/resources/manifest) | resource |
| [minio_iam_policy.pxc_pocliy](https://registry.terraform.io/providers/aminueza/minio/latest/docs/resources/iam_policy) | resource |
| [minio_iam_user.pxc_user](https://registry.terraform.io/providers/aminueza/minio/latest/docs/resources/iam_user) | resource |
| [minio_iam_user_policy_attachment.pxc_iam](https://registry.terraform.io/providers/aminueza/minio/latest/docs/resources/iam_user_policy_attachment) | resource |
| [minio_s3_bucket.pxc_bucket](https://registry.terraform.io/providers/aminueza/minio/latest/docs/resources/s3_bucket) | resource |
| [kubectl_path_documents.pxc_operator](https://registry.terraform.io/providers/alekc/kubectl/2.0.4/docs/data-sources/path_documents) | data source |
| [minio_iam_policy_document.pxc_policy](https://registry.terraform.io/providers/aminueza/minio/latest/docs/data-sources/iam_policy_document) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_enabled"></a> [backup\_enabled](#input\_backup\_enabled) | 是否开启备份 | `bool` | `false` | no |
| <a name="input_backup_minio_access_key"></a> [backup\_minio\_access\_key](#input\_backup\_minio\_access\_key) | 备份使用 Minio Access Key | `string` | `"backup"` | no |
| <a name="input_backup_minio_api_access"></a> [backup\_minio\_api\_access](#input\_backup\_minio\_api\_access) | 备份 Minio 地址 | `string` | `"minio.minio.svc.cluster.local"` | no |
| <a name="input_backup_minio_bucket"></a> [backup\_minio\_bucket](#input\_backup\_minio\_bucket) | 备份 Minio 存储桶相关信息 | <pre>map(object({<br>    storageName = string<br>    bucket      = string<br>  }))</pre> | <pre>{<br>  "backup": {<br>    "bucket": "mysql-backups",<br>    "storageName": "s3-backups"<br>  },<br>  "pitr": {<br>    "bucket": "mysql-binlogs",<br>    "storageName": "s3-binlogs"<br>  }<br>}</pre> | no |
| <a name="input_backup_minio_secret_key"></a> [backup\_minio\_secret\_key](#input\_backup\_minio\_secret\_key) | 备份使用 Minio Secret Key | `string` | `"Qwe123456@@"` | no |
| <a name="input_backup_minio_secret_name"></a> [backup\_minio\_secret\_name](#input\_backup\_minio\_secret\_name) | 备份 Minio Secret Name | `string` | `"minio-secret"` | no |
| <a name="input_backup_pitr_enabled"></a> [backup\_pitr\_enabled](#input\_backup\_pitr\_enabled) | 是否开启 binlogs 实时备份 | `bool` | `false` | no |
| <a name="input_backup_pitr_resources"></a> [backup\_pitr\_resources](#input\_backup\_pitr\_resources) | Backup Pitr 资源限制 | `map(any)` | <pre>{<br>  "backup": {<br>    "pitr": {<br>      "resources": {<br>        "limits": {},<br>        "requests": {}<br>      }<br>    }<br>  }<br>}</pre> | no |
| <a name="input_disableTLS"></a> [disableTLS](#input\_disableTLS) | 创建群集时是否关闭 TLS | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | 是否开启全局部署 | `bool` | `true` | no |
| <a name="input_fullnameOverride"></a> [fullnameOverride](#input\_fullnameOverride) | 全局名称 | `string` | `"prod"` | no |
| <a name="input_haproxy_resources"></a> [haproxy\_resources](#input\_haproxy\_resources) | Haproxy 资源限制 | `map(any)` | <pre>{<br>  "haproxy": {<br>    "resources": {<br>      "limits": {},<br>      "requests": {<br>        "cpu": "600m",<br>        "memory": "0.5G"<br>      }<br>    }<br>  }<br>}</pre> | no |
| <a name="input_logcollector_resources"></a> [logcollector\_resources](#input\_logcollector\_resources) | Logcollertor 资源限制 | `map(any)` | <pre>{<br>  "logcollector": {<br>    "resources": {<br>      "limits": {},<br>      "requests": {<br>        "cpu": "200m",<br>        "memory": "100M"<br>      }<br>    }<br>  }<br>}</pre> | no |
| <a name="input_minio_backup_enabled"></a> [minio\_backup\_enabled](#input\_minio\_backup\_enabled) | 是否开启 S3 备份, 将会创建桶 | `bool` | `true` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | 指定名称空间 | `string` | `"pxc-mysql"` | no |
| <a name="input_pause"></a> [pause](#input\_pause) | 是否优雅退出, 重启服务时会用到 | `bool` | `false` | no |
| <a name="input_pxc_resources"></a> [pxc\_resources](#input\_pxc\_resources) | PXC 资源限制 | `map(any)` | <pre>{<br>  "pxc": {<br>    "resources": {<br>      "limits": {},<br>      "requests": {<br>        "cpu": "600m",<br>        "memory": "1Gi"<br>      }<br>    }<br>  }<br>}</pre> | no |
| <a name="input_pxc_version"></a> [pxc\_version](#input\_pxc\_version) | PXC Operator 使用的版本 | `string` | `"1.14.0"` | no |
| <a name="input_storageClass"></a> [storageClass](#input\_storageClass) | 存储 Storage Class 使用的名称 | `string` | `"longhorn"` | no |
| <a name="input_storageSize"></a> [storageSize](#input\_storageSize) | 申请存储空间大小 | `string` | `"10Gi"` | no |
<!-- END_TF_DOCS -->
