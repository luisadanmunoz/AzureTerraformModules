# Terraform Module: ExpressRoute Circuit

Este módulo de Terraform crea un ExpressRoute Circuit en Azure para la conexión privada entre la infraestructura on-premises y la nube de Azure.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_express_route_circuit.express_route`: Crea un ExpressRoute Circuit.
- `azurerm_express_route_circuit_peering.peering`: Configura la conexión de peering para el ExpressRoute Circuit.
- `azurerm_virtual_network_gateway_connection.connection`: Conexión del ExpressRoute Circuit con una Virtual Network Gateway.
- `azurerm_monitor_diagnostic_setting.diagnostic_setting`: Configura el monitoreo de diagnóstico para ExpressRoute.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                          | Tipo        | Descripción                                               | Por defecto |
|---------------------------------|------------|-----------------------------------------------------------|------------|
| `name`                          | `string`   | Nombre del ExpressRoute Circuit.                         | -          |
| `resource_group_name`           | `string`   | Nombre del grupo de recursos donde se creará el circuito. | -          |
| `location`                      | `string`   | Ubicación del recurso.                                   | -          |
| `service_provider_name`         | `string`   | Nombre del proveedor del servicio de ExpressRoute.      | -          |
| `peering_location`              | `string`   | Ubicación del peering del ExpressRoute.                 | -          |
| `bandwidth_in_mbps`             | `number`   | Ancho de banda en Mbps del ExpressRoute.                | -          |
| `tier`                          | `string`   | Nivel del SKU (`Standard` o `Premium`).                 | -          |
| `family`                        | `string`   | Familia del SKU (`MeteredData` o `UnlimitedData`).      | -          |
| `tags`                          | `map(any)` | Etiquetas opcionales para el recurso.                   | `{}`       |
| `peering_type`                  | `string`   | Tipo de peering (`AzurePrivatePeering`, `MicrosoftPeering`). | -      |
| `express_route_circuit_name`    | `string`   | Nombre del circuito de ExpressRoute.                    | -          |
| `peer_asn`                      | `number`   | ASN del peer en el ExpressRoute.                        | -          |
| `primary_peer_address_prefix`   | `string`   | Prefijo de dirección IP primaria para el peering.       | -          |
| `secondary_peer_address_prefix` | `string`   | Prefijo de dirección IP secundaria para el peering.     | -          |
| `vlan_id`                       | `number`   | ID de la VLAN para el ExpressRoute.                     | -          |
| `name_connection`               | `string`   | Nombre de la conexión de la VNet Gateway con ExpressRoute. | -      |
| `virtual_network_gateway_id`    | `string`   | ID de la Virtual Network Gateway.                       | -          |
| `type`                          | `string`   | Tipo de conexión (`ExpressRoute`).                      | -          |
| `shared_key`                    | `string`   | Clave compartida para autenticación en la conexión.    | -          |
| `name_diagnostic_setting`       | `string`   | Nombre de la configuración de diagnóstico.              | -          |
| `workspace_resource_id`         | `string`   | ID del Log Analytics Workspace para monitoreo.          | -          |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre  | Descripción                                  |
|---------|----------------------------------------------|
| `id`    | ID del ExpressRoute Circuit.               |
| `name`  | Nombre del ExpressRoute Circuit.           |

## Uso

Ejemplo de uso del módulo:

```hcl
module "express_route" {
  source                       = "./ruta/al/modulo"
  name                         = "mi-express-route"
  resource_group_name          = "mi-grupo-de-recursos"
  location                     = "East US"
  service_provider_name        = "Equinix"
  peering_location             = "Silicon Valley"
  bandwidth_in_mbps            = 1000
  tier                         = "Standard"
  family                       = "MeteredData"
  peering_type                 = "AzurePrivatePeering"
  express_route_circuit_name   = "mi-express-route"
  peer_asn                     = 65000
  primary_peer_address_prefix  = "192.168.1.0/30"
  secondary_peer_address_prefix = "192.168.2.0/30"
  vlan_id                      = 200
  name_connection              = "express-route-connection"
  virtual_network_gateway_id   = "vnet-gateway-id"
  type                         = "ExpressRoute"
  shared_key                   = "mysharedkey"
  name_diagnostic_setting      = "express-route-diagnostics"
  workspace_resource_id        = "log-analytics-id"
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de ExpressRoute en Azure.

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
| [azurerm_bastion_host.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bastion_host) | resource |
| [azurerm_monitor_diagnostic_setting.diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_categories.diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | ############################################################################ AZURE BASTION ############################################################################ | `string` | n/a | yes |
| <a name="input_name_diagnostic_setting"></a> [name\_diagnostic\_setting](#input\_name\_diagnostic\_setting) | ############################################################################ DIAGNOSTIC SETTINGS ############################################################################ | `string` | n/a | yes |
| <a name="input_nameip"></a> [nameip](#input\_nameip) | n/a | `string` | n/a | yes |
| <a name="input_public_ip_address_id"></a> [public\_ip\_address\_id](#input\_public\_ip\_address\_id) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | n/a | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | `{}` | no |
| <a name="input_tunneling_enabled"></a> [tunneling\_enabled](#input\_tunneling\_enabled) | n/a | `bool` | n/a | yes |
| <a name="input_workspace_resource_id"></a> [workspace\_resource\_id](#input\_workspace\_resource\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ AZURE BASTION ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->