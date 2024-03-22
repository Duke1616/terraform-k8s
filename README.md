# infra

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.7.4 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_longhorn"></a> [longhorn](#module\_longhorn) | ./modules/longhorn | n/a |
| <a name="module_nfs-client-provisioner"></a> [nfs-client-provisioner](#module\_nfs-client-provisioner) | ./modules/nfs-client-provisioner | n/a |
| <a name="module_traefik"></a> [traefik](#module\_traefik) | ./modules/traefik | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_debug_output"></a> [enable\_debug\_output](#input\_enable\_debug\_output) | DEBUG 类型的日志输出 | `bool` | `false` | no |
| <a name="input_enable_info_output"></a> [enable\_info\_output](#input\_enable\_info\_output) | INFO 类型的日志输出 | `bool` | `false` | no |
| <a name="input_longhorn_enabled"></a> [longhorn\_enabled](#input\_longhorn\_enabled) | 是否开启 Longhorn 部署 | `bool` | `true` | no |
| <a name="input_nfs_enabled"></a> [nfs\_enabled](#input\_nfs\_enabled) | 是否开启 nfs-client-provisioner 部署 | `bool` | `true` | no |
| <a name="input_treafik_enabled"></a> [treafik\_enabled](#input\_treafik\_enabled) | 是否开启 Traefik 部署 | `bool` | `true` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nfs_manifest_yaml"></a> [nfs\_manifest\_yaml](#output\_nfs\_manifest\_yaml) | n/a |
| <a name="output_traefik_url"></a> [traefik\_url](#output\_traefik\_url) | n/a |
<!-- END_TF_DOCS -->
