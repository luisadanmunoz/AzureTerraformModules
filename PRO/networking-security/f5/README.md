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
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_linux_virtual_machine.bigip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.mgmt_nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface.private_nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface.public_nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_ssh_public_key.f5_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/ssh_public_key) | resource |
| [azurerm_user_assigned_identity.identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_virtual_machine_extension.vmext](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [tls_private_key.tls_private_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_AS3_URL"></a> [AS3\_URL](#input\_AS3\_URL) | URL to download the BIG-IP Application Service Extension 3 (AS3) module | `string` | `"https://github.com/F5Networks/f5-appsvcs-extension/releases/download/v3.51.0/f5-appsvcs-3.51.0-5.noarch.rpm"` | no |
| <a name="input_CFE_URL"></a> [CFE\_URL](#input\_CFE\_URL) | URL to download the BIG-IP Cloud Failover Extension module | `string` | `"https://github.com/F5Networks/f5-cloud-failover-extension/releases/download/v2.1.1/f5-cloud-failover-2.1.1-1.noarch.rpm"` | no |
| <a name="input_DO_URL"></a> [DO\_URL](#input\_DO\_URL) | URL to download the BIG-IP Declarative Onboarding module | `string` | `"https://github.com/F5Networks/f5-declarative-onboarding/releases/download/v1.44.0/f5-declarative-onboarding-1.44.0-5.noarch.rpm"` | no |
| <a name="input_FAST_URL"></a> [FAST\_URL](#input\_FAST\_URL) | URL to download the BIG-IP FAST module | `string` | `"https://github.com/F5Networks/f5-appsvcs-templates/releases/download/v1.25.0/f5-appsvcs-templates-1.25.0-1.noarch.rpm"` | no |
| <a name="input_INIT_URL"></a> [INIT\_URL](#input\_INIT\_URL) | URL to download the BIG-IP runtime init | `string` | `"https://cdn.f5.com/product/cloudsolutions/f5-bigip-runtime-init/v2.0.2/dist/f5-bigip-runtime-init-2.0.2-1.gz.run"` | no |
| <a name="input_TS_URL"></a> [TS\_URL](#input\_TS\_URL) | URL to download the BIG-IP Telemetry Streaming module | `string` | `"https://github.com/F5Networks/f5-telemetry-streaming/releases/download/v1.35.0/f5-telemetry-1.35.0-1.noarch.rpm"` | no |
| <a name="input_ip_management"></a> [ip\_management](#input\_ip\_management) | n/a | `string` | n/a | yes |
| <a name="input_ip_private"></a> [ip\_private](#input\_ip\_private) | n/a | `string` | n/a | yes |
| <a name="input_ip_public"></a> [ip\_public](#input\_ip\_public) | n/a | `string` | n/a | yes |
| <a name="input_ip_public_2"></a> [ip\_public\_2](#input\_ip\_public\_2) | n/a | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | ############################################################################ LINUX VIRTUAL MACHINE - F5 BIGIP - VARIABLES ############################################################################ | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | n/a | `string` | n/a | yes |
| <a name="input_subnet_mgmt_id"></a> [subnet\_mgmt\_id](#input\_subnet\_mgmt\_id) | n/a | `string` | n/a | yes |
| <a name="input_subnet_private_id"></a> [subnet\_private\_id](#input\_subnet\_private\_id) | n/a | `string` | n/a | yes |
| <a name="input_subnet_public_id"></a> [subnet\_public\_id](#input\_subnet\_public\_id) | n/a | `string` | n/a | yes |
| <a name="input_subnet_public_id_2"></a> [subnet\_public\_id\_2](#input\_subnet\_public\_id\_2) | n/a | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->