# Terraform Module: Local Network Gateway

Este módulo de Terraform crea un Local Network Gateway en Azure para la conexión de redes locales a través de VPN con una Virtual Network Gateway.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_local_network_gateway.lng`: Crea un Local Network Gateway en Azure.
- `azurerm_virtual_network_gateway_connection.lngconnection`: Crea una conexión entre el Local Network Gateway y la Virtual Network Gateway.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                          | Tipo         | Descripción                                              | Por defecto |
|---------------------------------|-------------|----------------------------------------------------------|------------|
| `name`                          | `string`    | Nombre del Local Network Gateway.                        | -          |
| `resource_group_name`           | `string`    | Nombre del grupo de recursos donde se creará el gateway. | -          |
| `location`                      | `string`    | Ubicación del recurso.                                   | -          |
| `gateway_address`               | `string`    | Dirección IP pública del Local Network Gateway.         | -          |
| `address_space`                 | `list(string)` | Lista de rangos de direcciones de la red local.         | -          |
| `name_connect`                  | `string`    | Nombre de la conexión VPN entre las redes.              | -          |
| `type`                          | `string`    | Tipo de conexión (`IPsec`).                              | -          |
| `virtual_network_gateway_id`    | `string`    | ID de la Virtual Network Gateway.                       | -          |
| `shared_key`                    | `string`    | Clave compartida para autenticación en la conexión VPN. | -          |
| `dh_group`                      | `string`    | Grupo Diffie-Hellman utilizado para la conexión.        | -          |
| `ike_encryption`                | `string`    | Algoritmo de cifrado IKE.                               | -          |
| `ike_integrity`                 | `string`    | Algoritmo de integridad IKE.                            | -          |
| `ipsec_encryption`              | `string`    | Algoritmo de cifrado IPsec.                             | -          |
| `ipsec_integrity`               | `string`    | Algoritmo de integridad IPsec.                          | -          |
| `pfs_group`                     | `string`    | Grupo PFS utilizado para la conexión.                   | -          |
| `sa_datasize`                   | `string`    | Tamaño de los paquetes de datos antes de renegociación. | -          |
| `sa_lifetime`                   | `string`    | Tiempo de vida de la asociación de seguridad en segundos. | -          |
| `tags`                          | `map(any)`  | Etiquetas opcionales para el recurso.                   | `{}`       |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre  | Descripción                                   |
|---------|-----------------------------------------------|
| `id`    | ID del Local Network Gateway.                |
| `name`  | Nombre del Local Network Gateway.            |

## Uso

Ejemplo de uso del módulo:

```hcl
module "local_network_gateway" {
  source                     = "./ruta/al/modulo"
  name                       = "mi-local-network-gateway"
  resource_group_name        = "mi-grupo-de-recursos"
  location                   = "East US"
  gateway_address            = "203.0.113.1"
  address_space              = ["192.168.1.0/24"]
  name_connect               = "vpn-connection"
  type                       = "IPsec"
  virtual_network_gateway_id = "vnet-gateway-id"
  shared_key                 = "mi-clave-compartida"
  dh_group                   = "DHGroup2"
  ike_encryption             = "AES256"
  ike_integrity              = "SHA256"
  ipsec_encryption           = "AES256"
  ipsec_integrity            = "SHA256"
  pfs_group                  = "PFS2"
  sa_datasize                = "104857600"
  sa_lifetime                = "27000"
  tags                       = { env = "prod" }
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de Local Network Gateway en Azure.
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_local_network_gateway.lng](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/local_network_gateway) | resource |
| [azurerm_virtual_network_gateway_connection.lngconection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | n/a | `list(string)` | n/a | yes |
| <a name="input_dh_group"></a> [dh\_group](#input\_dh\_group) | n/a | `string` | n/a | yes |
| <a name="input_gateway_address"></a> [gateway\_address](#input\_gateway\_address) | n/a | `string` | n/a | yes |
| <a name="input_ike_encryption"></a> [ike\_encryption](#input\_ike\_encryption) | n/a | `string` | n/a | yes |
| <a name="input_ike_integrity"></a> [ike\_integrity](#input\_ike\_integrity) | n/a | `string` | n/a | yes |
| <a name="input_ipsec_encryption"></a> [ipsec\_encryption](#input\_ipsec\_encryption) | n/a | `string` | n/a | yes |
| <a name="input_ipsec_integrity"></a> [ipsec\_integrity](#input\_ipsec\_integrity) | n/a | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | ############################################################################ LOCAL NETWORK GATEWAY VARIABLES ############################################################################ | `string` | n/a | yes |
| <a name="input_name_connect"></a> [name\_connect](#input\_name\_connect) | ############################################################################ VIRTUAL NETWORK GATEWAY CONNECTION ############################################################################ | `string` | n/a | yes |
| <a name="input_pfs_group"></a> [pfs\_group](#input\_pfs\_group) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_sa_datasize"></a> [sa\_datasize](#input\_sa\_datasize) | n/a | `string` | n/a | yes |
| <a name="input_sa_lifetime"></a> [sa\_lifetime](#input\_sa\_lifetime) | n/a | `string` | n/a | yes |
| <a name="input_shared_key"></a> [shared\_key](#input\_shared\_key) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | n/a | `string` | n/a | yes |
| <a name="input_virtual_network_gateway_id"></a> [virtual\_network\_gateway\_id](#input\_virtual\_network\_gateway\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ LOCAL NETWORK GATEWAY OUTPUT ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->