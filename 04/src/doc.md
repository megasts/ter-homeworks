## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.8.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_analytics_vm"></a> [analytics\_vm](#module\_analytics\_vm) | git::https://github.com/udjin10/yandex_compute_instance.git | main |
| <a name="module_marketing_vm"></a> [marketing\_vm](#module\_marketing\_vm) | git::https://github.com/udjin10/yandex_compute_instance.git | main |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [template_file.cloudinit](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | ID of the folder that the resource belongs to | `string` | n/a | yes |
| <a name="input_image_family"></a> [image\_family](#input\_image\_family) | OS type | `string` | `"ubuntu-2004-lts"` | no |
| <a name="input_prefix_vm"></a> [prefix\_vm](#input\_prefix\_vm) | example vm\_db\_ prefix | `string` | `"netology-project"` | no |
| <a name="input_project_analytics"></a> [project\_analytics](#input\_project\_analytics) | Name of the project | `string` | `"analytics"` | no |
| <a name="input_project_marketing"></a> [project\_marketing](#input\_project\_marketing) | Name of the project | `string` | `"marketing"` | no |
| <a name="input_service_account_key_file"></a> [service\_account\_key\_file](#input\_service\_account\_key\_file) | file\_key.json | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | for ubuntu | `string` | `"ubuntu"` | no |
| <a name="input_vms_ssh_root_key"></a> [vms\_ssh\_root\_key](#input\_vms\_ssh\_root\_key) | ssh-keygen -t ed25519 | `string` | `"~/.ssh/id_ed25519.pub"` | no |
| <a name="input_vpc_network_name"></a> [vpc\_network\_name](#input\_vpc\_network\_name) | Name of the network | `string` | `"develop"` | no |
| <a name="input_vpc_subnet_cidr"></a> [vpc\_subnet\_cidr](#input\_vpc\_subnet\_cidr) | A list of blocks of internal IPv4 addresses that are owned by this subnet | `list(string)` | <pre>[<br/>  "10.0.1.0/24"<br/>]</pre> | no |
| <a name="input_vpc_subnet_name"></a> [vpc\_subnet\_name](#input\_vpc\_subnet\_name) | Name of the subnet | `string` | `"develop"` | no |
| <a name="input_vpc_zone"></a> [vpc\_zone](#input\_vpc\_zone) | The zones field is an array of your availability zones | `string` | `"ru-central1-a"` | no |

## Outputs

No outputs.
