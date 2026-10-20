# Terraform Module: Fortinet FortiGate

Este módulo de Terraform despliega una máquina virtual Linux en Azure con Fortinet FortiGate preinstalado y configurado.

## Recursos

Este módulo define los siguientes recursos:

- `random_password.password`: Genera una contraseña aleatoria para la VM.
- `azurerm_key_vault_secret.vm_secret`: Almacena la contraseña en Azure Key Vault.
- `azurerm_network_interface.ha`: Configura la interfaz de red de alta disponibilidad.
- `azurerm_network_interface.public`: Configura la interfaz de red pública.
- `azurerm_network_interface.mgmt`: Configura la interfaz de administración.
- `azurerm_network_interface.private`: Configura la interfaz de red privada.
- `azurerm_linux_virtual_machine.linux_vm`: Despliega la máquina virtual Linux con Fortinet FortiGate.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                           | Tipo        | Descripción                                                  | Por defecto |
|----------------------------------|------------|--------------------------------------------------------------|------------|
| `secret_name`                    | `string`   | Nombre del secreto en Key Vault.                            | -          |
| `keyvault_id`                    | `string`   | ID del Key Vault donde se almacenará la contraseña.        | -          |
| `tags`                           | `map(any)` | Etiquetas comunes para los recursos.                        | `{}`       |
| `vm_name`                        | `string`   | Nombre de la máquina virtual.                               | -          |
| `location`                       | `string`   | Ubicación de la máquina virtual.                           | -          |
| `resource_group_name`            | `string`   | Nombre del grupo de recursos.                              | -          |
| `subnet_id_ha`                   | `string`   | ID de la subred de alta disponibilidad.                     | -          |
| `private_ip_address_ha`          | `string`   | Dirección IP privada de la HA.                              | -          |
| `subnet_id_public`               | `string`   | ID de la subred pública.                                    | -          |
| `private_ip_address_public`      | `string`   | Dirección IP privada pública.                               | -          |
| `subnet_id_mgmt`                 | `string`   | ID de la subred de administración.                         | -          |
| `private_ip_address_mgmt`        | `string`   | Dirección IP privada de administración.                     | -          |
| `subnet_id_private`              | `string`   | ID de la subred privada.                                    | -          |
| `private_ip_address_private`     | `string`   | Dirección IP privada de la red privada.                     | -          |
| `size`                           | `string`   | Tamaño de la máquina virtual.                              | -          |
| `admin_username`                 | `string`   | Nombre del usuario administrador.                          | -          |
| `publisher`                      | `string`   | Publicador de la imagen de Fortinet.                       | -          |
| `offer`                          | `string`   | Oferta de la imagen de Fortinet.                           | -          |
| `sku`                            | `string`   | SKU de la imagen de Fortinet.                              | -          |
| `os_version`                     | `string`   | Versión del sistema operativo de la imagen de Fortinet.    | -          |
| `os_disk`                        | `string`   | Nombre del disco del sistema operativo.                    | -          |
| `floating-public`                | `bool`     | Habilita la IP flotante pública.                           | `false`    |
| `floating-private`               | `bool`     | Habilita la IP flotante privada.                           | `false`    |

## Uso

Ejemplo de uso del módulo:

```hcl
module "fortinet_fortigate" {
  source                = "./ruta/al/modulo"
  vm_name               = "fortigate-instance"
  resource_group_name   = "mi-grupo-de-recursos"
  location              = "East US"
  size                  = "Standard_D2s_v3"
  subnet_id_ha          = "subnet-ha-id"
  private_ip_address_ha = "10.0.0.4"
  subnet_id_public      = "subnet-public-id"
  private_ip_address_public = "10.0.1.4"
  subnet_id_mgmt        = "subnet-mgmt-id"
  private_ip_address_mgmt = "10.0.2.4"
  subnet_id_private     = "subnet-private-id"
  private_ip_address_private = "10.0.3.4"
  admin_username        = "admin"
  publisher             = "fortinet"
  offer                 = "fortinet_fortigate-vm_v5"
  sku                   = "fortinet_fg-vm_payg_2023"
  os_version            = "7.2.8"
  os_disk               = "fortigate-os-disk"
  floating-public       = false
  floating-private      = false
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la implementación de Fortinet FortiGate en Azure sobre una máquina virtual Linux.
