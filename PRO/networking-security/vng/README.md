# Terraform Module: Virtual Network Gateway (VNG)

Este módulo de Terraform crea y configura un Virtual Network Gateway (VNG) en Azure para conexiones VPN o ExpressRoute.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_virtual_network_gateway.vng`: Crea un Virtual Network Gateway en Azure.
- `azurerm_monitor_diagnostic_setting.diagnostic_setting`: Configura el monitoreo y diagnóstico del Virtual Network Gateway.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                      | Tipo        | Descripción                                              | Por defecto |
|-----------------------------|------------|----------------------------------------------------------|------------|
| `name`                      | `string`   | Nombre del Virtual Network Gateway.                     | -          |
| `location`                  | `string`   | Ubicación donde se desplegará el Virtual Network Gateway. | -          |
| `resource_group_name`       | `string`   | Nombre del grupo de recursos donde se creará el VNG.    | -          |
| `type`                      | `string`   | Tipo de gateway (`Vpn` o `ExpressRoute`).               | -          |
| `vpn_type`                  | `string`   | Tipo de VPN (`RouteBased` o `PolicyBased`).             | -          |
| `active_active`             | `string`   | Habilita el modo activo-activo.                         | -          |
| `enable_bgp`                | `string`   | Habilita el protocolo BGP.                              | -          |
| `sku`                       | `string`   | SKU del Virtual Network Gateway (`Basic`, `Standard`, etc.). | -          |
| `public_ip_address_id`      | `string`   | ID de la IP pública asociada al VNG.                    | -          |
| `subnet_id`                 | `string`   | ID de la subred donde se desplegará el VNG.            | -          |
| `tags`                      | `map(any)` | Etiquetas opcionales para el recurso.                   | `{}`       |
| `name_diagnostic_setting`   | `string`   | Nombre de la configuración de diagnóstico.              | -          |
| `workspace_resource_id`     | `string`   | ID del Log Analytics Workspace para monitoreo.          | -          |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre  | Descripción                              |
|---------|------------------------------------------|
| `id`    | ID del Virtual Network Gateway.         |
| `name`  | Nombre del Virtual Network Gateway.     |

## Uso

Ejemplo de uso del módulo:

```hcl
module "vng" {
  source                    = "./ruta/al/modulo"
  name                      = "mi-vng"
  location                  = "East US"
  resource_group_name       = "mi-grupo-de-recursos"
  type                      = "Vpn"
  vpn_type                  = "RouteBased"
  active_active             = "true"
  enable_bgp                = "false"
  sku                       = "VpnGw2"
  public_ip_address_id      = "public-ip-id"
  subnet_id                 = "subnet-id"
  tags                      = { env = "prod" }
  name_diagnostic_setting   = "vng-diagnostics"
  workspace_resource_id     = "log-analytics-id"
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de Virtual Network Gateway en Azure.
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
| [azurerm_monitor_diagnostic_setting.diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_virtual_network_gateway.vng](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway) | resource |
| [azurerm_monitor_diagnostic_categories.diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_active_active"></a> [active\_active](#input\_active\_active) | n/a | `string` | n/a | yes |
| <a name="input_enable_bgp"></a> [enable\_bgp](#input\_enable\_bgp) | n/a | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | ############################################################################ VIRTUAL NETWORK GATEWAY VARIABLES ############################################################################ | `string` | n/a | yes |
| <a name="input_name_diagnostic_setting"></a> [name\_diagnostic\_setting](#input\_name\_diagnostic\_setting) | ############################################################################ DIAGNOSTIC SETTINGS ############################################################################ | `string` | n/a | yes |
| <a name="input_public_ip_address_id"></a> [public\_ip\_address\_id](#input\_public\_ip\_address\_id) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | n/a | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | n/a | `string` | n/a | yes |
| <a name="input_vpn_type"></a> [vpn\_type](#input\_vpn\_type) | n/a | `string` | n/a | yes |
| <a name="input_workspace_resource_id"></a> [workspace\_resource\_id](#input\_workspace\_resource\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ VIRTUAL NETWORK GATEWAY OUTPUT ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->