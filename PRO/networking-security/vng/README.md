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