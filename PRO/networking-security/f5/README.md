# Terraform Module: F5 BIG-IP

Este módulo de Terraform crea una máquina virtual Linux en Azure con F5 BIG-IP preinstalado y configurado.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_linux_virtual_machine.bigip`: Despliega la máquina virtual Linux con F5 BIG-IP.
- `azurerm_network_interface.mgmt_nic`: Configura la interfaz de red de administración.
- `azurerm_network_interface.private_nic`: Configura la interfaz de red privada.
- `azurerm_network_interface.public_nic`: Configura la interfaz de red pública.
- `azurerm_virtual_machine_extension.vmext`: Extensión de máquina virtual para configuración inicial.
- `azurerm_user_assigned_identity.identity`: Identidad asignada al usuario.
- `azurerm_ssh_public_key.f5_key`: Clave pública SSH para la máquina virtual.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                   | Tipo        | Descripción                                                  | Por defecto |
|--------------------------|------------|--------------------------------------------------------------|------------|
| `name`                   | `string`   | Nombre de la máquina virtual F5 BIG-IP.                     | -          |
| `resource_group_name`    | `string`   | Nombre del grupo de recursos en el que se desplegará.       | -          |
| `location`               | `string`   | Ubicación donde se creará el recurso.                       | -          |
| `size`                   | `string`   | Tamaño de la máquina virtual.                               | -          |
| `subnet_mgmt_id`         | `string`   | ID de la subred de administración.                          | -          |
| `subnet_private_id`      | `string`   | ID de la subred privada.                                    | -          |
| `subnet_public_id`       | `string`   | ID de la subred pública.                                    | -          |
| `subnet_public_id_2`     | `string`   | ID de la segunda subred pública.                           | -          |
| `zone`                   | `string`   | Zona de disponibilidad en la que se desplegará.             | -          |
| `ip_public`              | `string`   | Dirección IP pública.                                       | -          |
| `ip_public_2`            | `string`   | Segunda dirección IP pública.                              | -          |
| `ip_private`             | `string`   | Dirección IP privada.                                       | -          |
| `ip_management`          | `string`   | Dirección IP de administración.                            | -          |
| `INIT_URL`               | `string`   | URL para la inicialización de BIG-IP Runtime Init.          | Ver código |
| `DO_URL`                 | `string`   | URL para la descarga de Declarative Onboarding.            | Ver código |
| `AS3_URL`                | `string`   | URL para la descarga de Application Service Extension 3.   | Ver código |
| `TS_URL`                 | `string`   | URL para la descarga de Telemetry Streaming.               | Ver código |
| `CFE_URL`                | `string`   | URL para la descarga de Cloud Failover Extension.          | Ver código |
| `FAST_URL`               | `string`   | URL para la descarga de FAST Module.                       | Ver código |

## Uso

Ejemplo de uso del módulo:

```hcl
module "f5_bigip" {
  source              = "./ruta/al/modulo"
  name                = "bigip-instance"
  resource_group_name = "mi-grupo-de-recursos"
  location            = "East US"
  size                = "Standard_D2s_v3"
  subnet_mgmt_id      = "subnet-mgmt-id"
  subnet_private_id   = "subnet-private-id"
  subnet_public_id    = "subnet-public-id"
  subnet_public_id_2  = "subnet-public-id-2"
  zone                = "1"
  ip_public           = "10.0.1.4"
  ip_public_2         = "10.0.1.5"
  ip_private          = "10.0.2.4"
  ip_management       = "10.0.3.4"
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la implementación de F5 BIG-IP en Azure sobre una máquina virtual Linux.