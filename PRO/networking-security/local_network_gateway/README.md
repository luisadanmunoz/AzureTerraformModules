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