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
## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.12.1 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | 2.0.4 |

## Resources

| Name | Type |
|------|------|
| [helm_release.pxc_db_deploy](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.pxc_operator_deploy](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.pxc_operator](https://registry.terraform.io/providers/alekc/kubectl/2.0.4/docs/resources/manifest) | resource |
| [kubectl_path_documents.pxc_operator](https://registry.terraform.io/providers/alekc/kubectl/2.0.4/docs/data-sources/path_documents) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_pitr_resources"></a> [backup\_pitr\_resources](#input\_backup\_pitr\_resources) | Backup Pitr 资源限制 | `map(any)` | <pre>{<br>  "backup": {<br>    "pitr": {<br>      "resources": {<br>        "limits": {},<br>        "requests": {}<br>      }<br>    }<br>  }<br>}</pre> | no |
| <a name="input_disableTLS"></a> [disableTLS](#input\_disableTLS) | 创建群集时是否关闭 TLS | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | 是否开启全局部署 | `bool` | `true` | no |
| <a name="input_haproxy_resources"></a> [haproxy\_resources](#input\_haproxy\_resources) | Haproxy 资源限制 | `map(any)` | <pre>{<br>  "haproxy": {<br>    "resources": {<br>      "limits": {},<br>      "requests": {<br>        "cpu": "600m",<br>        "memory": "0.5G"<br>      }<br>    }<br>  }<br>}</pre> | no |
| <a name="input_logcollector_resources"></a> [logcollector\_resources](#input\_logcollector\_resources) | Logcollertor 资源限制 | `map(any)` | <pre>{<br>  "logcollector": {<br>    "resources": {<br>      "limits": {},<br>      "requests": {<br>        "cpu": "200m",<br>        "memory": "100M"<br>      }<br>    }<br>  }<br>}</pre> | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | 指定名称空间 | `string` | `"pxc-mysql"` | no |
| <a name="input_pause"></a> [pause](#input\_pause) | 是否优雅退出, 重启服务时会用到 | `bool` | `false` | no |
| <a name="input_prevent_destroy"></a> [prevent\_destroy](#input\_prevent\_destroy) | 设置为 true 不允许卸载应用 | `bool` | `true` | no |
| <a name="input_pxc_resources"></a> [pxc\_resources](#input\_pxc\_resources) | PXC 资源限制 | `map(any)` | <pre>{<br>  "pxc": {<br>    "resources": {<br>      "limits": {<br>        "memory": "512Mi"<br>      },<br>      "requests": {<br>        "cpu": "100m",<br>        "memory": "512Mi"<br>      }<br>    }<br>  }<br>}</pre> | no |
| <a name="input_pxc_version"></a> [pxc\_version](#input\_pxc\_version) | PXC Operator 使用的版本 | `string` | `"1.14.0"` | no |
| <a name="input_storageClass"></a> [storageClass](#input\_storageClass) | 存储 Storage Class 使用的名称 | `string` | `"longhorn"` | no |
| <a name="input_storageSize"></a> [storageSize](#input\_storageSize) | 申请存储空间大小 | `string` | `"10Gi"` | no |
<!-- END_TF_DOCS -->