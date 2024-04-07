# psmdb-operator

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.4 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.12.1 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 2.0.4 |
| <a name="requirement_minio"></a> [minio](#requirement\_minio) | >= 2.2.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.12.1 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 2.0.4 |
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_psmdb-minio"></a> [psmdb-minio](#module\_psmdb-minio) | ../minio | n/a |
## Resources

| Name | Type |
|------|------|
| [helm_release.psmdb_db_deploy](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.psmdb_operator_deploy](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.psmdb_operator](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_path_documents.psmdb_operator](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/data-sources/path_documents) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bacckup_password"></a> [bacckup\_password](#input\_bacckup\_password) | 备份恢复用户 | `string` | `"lLns9YE88V1GvywJzTOv"` | no |
| <a name="input_backup_enabled"></a> [backup\_enabled](#input\_backup\_enabled) | 是否开启备份 | `bool` | `true` | no |
| <a name="input_backup_minio_access_key"></a> [backup\_minio\_access\_key](#input\_backup\_minio\_access\_key) | 备份使用 Minio Access Key | `string` | `"backup"` | no |
| <a name="input_backup_minio_api_access"></a> [backup\_minio\_api\_access](#input\_backup\_minio\_api\_access) | 备份 Minio API 地址 | `string` | `"minio.minio.svc.cluster.local"` | no |
| <a name="input_backup_minio_bucket"></a> [backup\_minio\_bucket](#input\_backup\_minio\_bucket) | 备份 Minio 存储桶相关信息 | <pre>map(object({<br>    storageName = string<br>    bucket      = string<br>  }))</pre> | <pre>{<br>  "backup": {<br>    "bucket": "mongo-backups",<br>    "storageName": "s3-backups"<br>  }<br>}</pre> | no |
| <a name="input_backup_minio_policy_name"></a> [backup\_minio\_policy\_name](#input\_backup\_minio\_policy\_name) | 备份 Minio 使用的 Policy Name | `string` | `"psmdb-backup"` | no |
| <a name="input_backup_minio_secret_key"></a> [backup\_minio\_secret\_key](#input\_backup\_minio\_secret\_key) | 备份使用 Minio Secret Key | `string` | `"Qwe123456@@"` | no |
| <a name="input_backup_minio_secret_name"></a> [backup\_minio\_secret\_name](#input\_backup\_minio\_secret\_name) | 备份 Minio Secret Name | `string` | `"minio-secret"` | no |
| <a name="input_backup_pitr_enabled"></a> [backup\_pitr\_enabled](#input\_backup\_pitr\_enabled) | 是否开启 oplogs 实时备份 | `bool` | `true` | no |
| <a name="input_cluster_admin_password"></a> [cluster\_admin\_password](#input\_cluster\_admin\_password) | 集群管理员 | `string` | `"d1yeYMYjo1YlWZnwcP63"` | no |
| <a name="input_cluster_monitor_password"></a> [cluster\_monitor\_password](#input\_cluster\_monitor\_password) | 集群监控 | `string` | `"UxqbotjiOXuxFWy3fxxB"` | no |
| <a name="input_database_admin_password"></a> [database\_admin\_password](#input\_database\_admin\_password) | 数据库管理员用户 | `string` | `"3a3CkjMjvX2skgqWZAXI"` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | 是否开启全局部署 | `bool` | `true` | no |
| <a name="input_fullnameOverride"></a> [fullnameOverride](#input\_fullnameOverride) | 全局名称 | `string` | `"prod"` | no |
| <a name="input_minio_backup_enabled"></a> [minio\_backup\_enabled](#input\_minio\_backup\_enabled) | 是否开启 S3 备份, 将会创建桶 | `bool` | `true` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | 指定名称空间 | `string` | `"ps-mongo"` | no |
| <a name="input_pause"></a> [pause](#input\_pause) | 是否优雅退出, 重启服务时会用到 | `bool` | `false` | no |
| <a name="input_psmdb_db_resources"></a> [psmdb\_db\_resources](#input\_psmdb\_db\_resources) | psmdb db 资源限制 | `map(any)` | <pre>{<br>  "limits": {<br>    "cpu": "500m",<br>    "memory": "0.7G"<br>  },<br>  "requests": {<br>    "cpu": "500m",<br>    "memory": "0.7G"<br>  }<br>}</pre> | no |
| <a name="input_psmdb_db_version"></a> [psmdb\_db\_version](#input\_psmdb\_db\_version) | PS Mongo db 使用的版本 | `string` | `"1.15.3"` | no |
| <a name="input_psmdb_operator_version"></a> [psmdb\_operator\_version](#input\_psmdb\_operator\_version) | PS Mongo Operator 使用的版本 | `string` | `"1.15.4"` | no |
| <a name="input_sharding_eanbled"></a> [sharding\_eanbled](#input\_sharding\_eanbled) | 是否开启sharding cluster 模式部署 | `bool` | `false` | no |
| <a name="input_storageClass"></a> [storageClass](#input\_storageClass) | 存储 Storage Class 使用的名称 | `string` | `"longhorn"` | no |
| <a name="input_storageSize"></a> [storageSize](#input\_storageSize) | 申请存储空间大小 | `string` | `"15Gi"` | no |
| <a name="input_user_admin_password"></a> [user\_admin\_password](#input\_user\_admin\_password) | 用户管理 | `string` | `"FDUGiEEZY6zCwWCYSuyV"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_yaml_encoded_variable"></a> [yaml\_encoded\_variable](#output\_yaml\_encoded\_variable) | n/a |
<!-- END_TF_DOCS -->
