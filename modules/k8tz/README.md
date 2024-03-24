# k8tz

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
| [helm_release.k8tz_deploy](https://registry.terraform.io/providers/hashicorp/helm/2.12.1/docs/resources/release) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enabled"></a> [enabled](#input\_enabled) | 是否开启全局部署 | `bool` | `true` | no |
| <a name="input_injectAll"></a> [injectAll](#input\_injectAll) | 是否所有容器自动注入 | `bool` | `true` | no |
| <a name="input_k8tz_version"></a> [k8tz\_version](#input\_k8tz\_version) | K8TZ 使用的版本 | `string` | `"0.16.0"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | 指定名称空间 | `string` | `"k8tz"` | no |
| <a name="input_replicaCount"></a> [replicaCount](#input\_replicaCount) | 启动副本数量 | `number` | `3` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | 设置容器时区 | `string` | `"Asia/Shanghai"` | no |
<!-- END_TF_DOCS -->
