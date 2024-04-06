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

## Resources

| Name | Type |
|------|------|
| [helm_release.psmdb_db_deploy](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.psmdb_operator_deploy](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bacckup_password"></a> [bacckup\_password](#input\_bacckup\_password) | 备份恢复用户 | `string` | `"lLns9YE88V1GvywJzTOv"` | no |
| <a name="input_backup_enabled"></a> [backup\_enabled](#input\_backup\_enabled) | 是否开启备份 | `bool` | `false` | no |
| <a name="input_cluster_admin_password"></a> [cluster\_admin\_password](#input\_cluster\_admin\_password) | 集群管理员 | `string` | `"d1yeYMYjo1YlWZnwcP63"` | no |
| <a name="input_cluster_monitor_password"></a> [cluster\_monitor\_password](#input\_cluster\_monitor\_password) | 集群监控 | `string` | `"UxqbotjiOXuxFWy3fxxB"` | no |
| <a name="input_database_admin_password"></a> [database\_admin\_password](#input\_database\_admin\_password) | 数据库管理员用户 | `string` | `"3a3CkjMjvX2skgqWZAXI"` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | 是否开启全局部署 | `bool` | `true` | no |
| <a name="input_fullnameOverride"></a> [fullnameOverride](#input\_fullnameOverride) | 全局名称 | `string` | `"prod"` | no |
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
