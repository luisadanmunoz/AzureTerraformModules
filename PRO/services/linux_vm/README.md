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