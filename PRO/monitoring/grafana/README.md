# Terraform Module: Grafana VM

Este módulo de Terraform despliega una máquina virtual Linux en Azure con Grafana preinstalado y configurado.

## Recursos

Este módulo define los siguientes recursos:

- `random_password.password_grafana`: Genera una contraseña aleatoria para Grafana.
- `azurerm_key_vault_secret.vm_secret_grafana`: Almacena la contraseña en Azure Key Vault.
- `azurerm_network_interface.nic_grafana`: Crea una interfaz de red para la VM.
- `azurerm_linux_virtual_machine.linux_vm_grafana`: Despliega la máquina virtual Linux con Grafana.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                           | Tipo        | Descripción                                                  | Por defecto |
|----------------------------------|------------|--------------------------------------------------------------|------------|
| `secret_name`                    | `string`   | Nombre del secreto en Key Vault.                            | -          |
| `keyvault_id`                    | `string`   | ID del Key Vault donde se almacenará la contraseña.        | -          |
| `commom_tags`                    | `map(any)` | Etiquetas comunes para los recursos.                        | `{}`       |
| `vm_name`                         | `string`   | Nombre de la máquina virtual.                               | -          |
| `location`                        | `string`   | Ubicación de la máquina virtual.                           | -          |
| `resource_group_name`             | `string`   | Nombre del grupo de recursos.                              | -          |
| `subnet_id`                       | `string`   | ID de la subred donde se desplegará la VM.                 | -          |
| `private_ip_address_allocation`   | `string`   | Método de asignación de la IP privada (Static/Dynamic).    | -          |
| `private_ip_address`              | `string`   | Dirección IP privada de la VM si se usa asignación estática. | -          |
| `size`                            | `string`   | Tamaño de la máquina virtual.                              | -          |
| `admin_username`                  | `string`   | Nombre del usuario administrador.                          | -          |
| `computer_name`                   | `string`   | Nombre del equipo dentro del sistema operativo.            | -          |

## Uso

Ejemplo de uso del módulo:

```hcl
module "grafana" {
  source                        = "./ruta/al/modulo"
  secret_name                   = "grafana-secret"
  keyvault_id                   = "keyvault-id"
  commom_tags                   = { env = "prod" }
  vm_name                       = "grafana-vm"
  location                      = "East US"
  resource_group_name           = "mi-grupo-de-recursos"
  subnet_id                     = "subnet-id"
  private_ip_address_allocation = "Static"
  private_ip_address            = "10.0.0.10"
  size                          = "Standard_B2s"
  admin_username                = "admin"
  computer_name                 = "grafana-server"
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la implementación de Grafana en Azure sobre una máquina virtual Linux.
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.1.3 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.3 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_key_vault_secret.vm_secret_grafana](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_linux_virtual_machine.linux_vm_grafana](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.nic_grafana](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [random_password.password_grafana](https://registry.terraform.io/providers/hashicorp/random/3.1.3/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | value of the admin username tag | `string` | n/a | yes |
| <a name="input_commom_tags"></a> [commom\_tags](#input\_commom\_tags) | value of the commom tags tag | `map(any)` | `{}` | no |
| <a name="input_computer_name"></a> [computer\_name](#input\_computer\_name) | value of the computer name tag | `string` | n/a | yes |
| <a name="input_keyvault_id"></a> [keyvault\_id](#input\_keyvault\_id) | value of the keyvault id tag | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | value of the location tag | `string` | n/a | yes |
| <a name="input_private_ip_address"></a> [private\_ip\_address](#input\_private\_ip\_address) | value of the private ip address tag | `string` | n/a | yes |
| <a name="input_private_ip_address_allocation"></a> [private\_ip\_address\_allocation](#input\_private\_ip\_address\_allocation) | value of the private ip address allocation tag | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value of the resource group name tag | `string` | n/a | yes |
| <a name="input_secret_name"></a> [secret\_name](#input\_secret\_name) | value of the secret name tag | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | value of the size tag | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | value of the subnet id tag | `string` | n/a | yes |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | value of the vm name tag | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->