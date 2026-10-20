# Terraform Module: Linux Virtual Machine (VM)

Este módulo de Terraform crea y configura una máquina virtual Linux en Azure con una extensión de Azure Monitor y almacenamiento de credenciales en Key Vault.

## Recursos

Este módulo define los siguientes recursos:

- `random_password.password`: Genera una contraseña aleatoria para la VM.
- `azurerm_key_vault_secret.vm_secret`: Almacena la contraseña en un Azure Key Vault.
- `azurerm_network_interface.nic`: Crea una interfaz de red para la VM.
- `azurerm_linux_virtual_machine.linux_vm`: Crea una máquina virtual Linux en Azure.
- `azurerm_virtual_machine_extension.ama`: Instala la extensión de Azure Monitor en la VM.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                          | Tipo        | Descripción                                                      | Por defecto |
|---------------------------------|------------|------------------------------------------------------------------|------------|
| `vm_name`                       | `string`   | Nombre de la máquina virtual.                                   | -          |
| `location`                      | `string`   | Ubicación donde se desplegará la VM.                           | -          |
| `resource_group_name`           | `string`   | Nombre del grupo de recursos donde se creará la VM.            | -          |
| `subnet_id`                     | `string`   | ID de la subred donde se conectará la VM.                      | -          |
| `private_ip_address_allocation` | `string`   | Método de asignación de IP privada (`Static` o `Dynamic`).     | -          |
| `private_ip_address`            | `string`   | Dirección IP privada si se usa asignación estática.            | -          |
| `size`                          | `string`   | Tamaño de la máquina virtual.                                  | -          |
| `admin_username`                | `string`   | Nombre de usuario administrador de la VM.                      | -          |
| `publisher`                     | `string`   | Publicador de la imagen de la VM.                              | -          |
| `offer`                         | `string`   | Oferta de la imagen de la VM.                                  | -          |
| `sku`                           | `string`   | SKU de la imagen de la VM.                                     | -          |
| `os_version`                    | `string`   | Versión de la imagen de la VM.                                 | -          |
| `keyvault_id`                   | `string`   | ID del Azure Key Vault donde se almacenará la contraseña.      | -          |
| `tags`                          | `map(any)` | Etiquetas opcionales para el recurso.                          | `{}`       |

## Outputs

Este módulo no define outputs específicos.

## Uso

Ejemplo de uso del módulo:

```hcl
module "linux_vm" {
  source                        = "./ruta/al/modulo"
  vm_name                       = "mi-linux-vm"
  location                      = "East US"
  resource_group_name           = "mi-grupo-de-recursos"
  subnet_id                     = "subnet-id"
  private_ip_address_allocation = "Static"
  private_ip_address            = "10.0.0.10"
  size                          = "Standard_D2s_v3"
  admin_username                = "adminuser"
  publisher                     = "Canonical"
  offer                         = "UbuntuServer"
  sku                           = "18.04-LTS"
  os_version                    = "latest"
  keyvault_id                   = "keyvault-id"
  tags                          = { env = "prod" }
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de máquinas virtuales Linux en Azure con integración en Key Vault y monitorización mediante extensiones.
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.5.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.5.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_key_vault_secret.vm_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_linux_virtual_machine.linux_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_virtual_machine_extension.ama](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | n/a | `map` | `{}` | no |
| <a name="input_keyvault_id"></a> [keyvault\_id](#input\_keyvault\_id) | ############################################################################ RANDOM PASSWORD ############################################################################ | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_offer"></a> [offer](#input\_offer) | n/a | `map` | `{}` | no |
| <a name="input_os_version"></a> [os\_version](#input\_os\_version) | n/a | `map` | `{}` | no |
| <a name="input_private_ip_address"></a> [private\_ip\_address](#input\_private\_ip\_address) | n/a | `string` | n/a | yes |
| <a name="input_private_ip_address_allocation"></a> [private\_ip\_address\_allocation](#input\_private\_ip\_address\_allocation) | n/a | `string` | n/a | yes |
| <a name="input_publisher"></a> [publisher](#input\_publisher) | n/a | `map` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | ############################################################################ LINUX VIRTUAL MACHINE MODULE ############################################################################ | `map` | `{}` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | n/a | `map` | `{}` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | `{}` | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | ############################################################################ LINUX VIRTUAL MACHINE MODULE - NETWORK INTERFACE ############################################################################ | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->