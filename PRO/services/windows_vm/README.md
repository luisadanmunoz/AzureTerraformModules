## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_secret.vm_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_network_interface.nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_windows_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | n/a | `map` | `{}` | no |
| <a name="input_caching"></a> [caching](#input\_caching) | n/a | `map` | `{}` | no |
| <a name="input_computer_name"></a> [computer\_name](#input\_computer\_name) | n/a | `map` | `{}` | no |
| <a name="input_keyvault_id"></a> [keyvault\_id](#input\_keyvault\_id) | ############################################################################ KEY VAULT SECRET ############################################################################ | `map` | `{}` | no |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | n/a | `map` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `map` | `{}` | no |
| <a name="input_offer"></a> [offer](#input\_offer) | n/a | `map` | `{}` | no |
| <a name="input_os_version"></a> [os\_version](#input\_os\_version) | n/a | `map` | `{}` | no |
| <a name="input_private_ip_address"></a> [private\_ip\_address](#input\_private\_ip\_address) | n/a | `map` | `{}` | no |
| <a name="input_private_ip_address_allocation"></a> [private\_ip\_address\_allocation](#input\_private\_ip\_address\_allocation) | n/a | `map` | `{}` | no |
| <a name="input_publisher"></a> [publisher](#input\_publisher) | n/a | `map` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `map` | `{}` | no |
| <a name="input_size"></a> [size](#input\_size) | n/a | `map` | `{}` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | n/a | `map` | `{}` | no |
| <a name="input_storage_account_type"></a> [storage\_account\_type](#input\_storage\_account\_type) | n/a | `map` | `{}` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ############################################################################ WINDOWS VIRTUAL MACHINE MODULE - NETWORK INTERFACE ############################################################################ | `map` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | `{}` | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | ############################################################################ WINDOWS VIRTUAL MACHINE ############################################################################ | `map` | `{}` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | n/a | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ WINDOWS VIRTUAL MACHINE OUTPUT ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_size"></a> [size](#output\_size) | n/a |
