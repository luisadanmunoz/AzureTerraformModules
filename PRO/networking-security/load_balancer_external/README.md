# Terraform Module: External Load Balancer

Este módulo de Terraform crea un Load Balancer externo en Azure con configuración de backend y reglas de balanceo de carga.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_lb.lbe`: Crea un Load Balancer externo.
- `azurerm_lb_backend_address_pool.lbe_backend_address_pool`: Configura el backend del Load Balancer.
- `azurerm_network_interface_backend_address_pool_association.nic-pa-hub-01-nic-untrust`: Asocia la interfaz de red 01 al backend del Load Balancer.
- `azurerm_network_interface_backend_address_pool_association.nic-pa-hub-02-nic-untrust`: Asocia la interfaz de red 02 al backend del Load Balancer.
- `azurerm_lb_probe.lbe_probe`: Crea un probe TCP para monitorear la disponibilidad.
- `azurerm_lb_rule.lb_rule`: Crea una regla de balanceo de carga en el Load Balancer.
- `azurerm_monitor_diagnostic_setting.diagnostic_setting`: Configura el monitoreo y diagnóstico del Load Balancer.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                            | Tipo        | Descripción                                                      | Por defecto |
|-----------------------------------|------------|------------------------------------------------------------------|------------|
| `name`                            | `string`   | Nombre del Load Balancer.                                       | -          |
| `location`                        | `string`   | Ubicación del Load Balancer.                                    | -          |
| `resource_group_name`             | `string`   | Nombre del grupo de recursos donde se creará el Load Balancer.  | -          |
| `sku`                             | `string`   | SKU del Load Balancer.                                          | -          |
| `name_ip`                         | `string`   | Nombre de la configuración IP del frontend.                     | -          |
| `public_ip_address_id`            | `string`   | ID de la dirección IP pública asociada al Load Balancer.       | -          |
| `tags`                            | `map(any)` | Etiquetas opcionales para el recurso.                          | `{}`       |
| `network_interface_id_01`         | `string`   | ID de la primera interfaz de red del backend.                  | -          |
| `network_interface_id_02`         | `string`   | ID de la segunda interfaz de red del backend.                  | -          |
| `ip_configuration_name_01`        | `string`   | Nombre de la configuración IP de la primera interfaz de red.    | -          |
| `ip_configuration_name_02`        | `string`   | Nombre de la configuración IP de la segunda interfaz de red.    | -          |
| `backend_address_pool_ids`        | `list(string)` | Lista de IDs de los backend address pools.                    | -          |
| `name_diagnostic_setting`         | `string`   | Nombre de la configuración de diagnóstico.                     | -          |
| `workspace_resource_id`           | `string`   | ID del Log Analytics Workspace para monitoreo.                 | -          |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre  | Descripción                                  |
|---------|----------------------------------------------|
| `id`    | ID del Load Balancer.                       |
| `name`  | Nombre del Load Balancer.                   |

## Uso

Ejemplo de uso del módulo:

```hcl
module "load_balancer_external" {
  source                    = "./ruta/al/modulo"
  name                      = "mi-load-balancer"
  location                  = "East US"
  resource_group_name       = "mi-grupo-de-recursos"
  sku                       = "Standard"
  name_ip                   = "frontend-ip"
  public_ip_address_id      = "public-ip-id"
  tags                      = { env = "prod" }
  network_interface_id_01   = "nic-01-id"
  network_interface_id_02   = "nic-02-id"
  ip_configuration_name_01  = "ip-config-01"
  ip_configuration_name_02  = "ip-config-02"
  backend_address_pool_ids  = ["backend-pool-id"]
  name_diagnostic_setting   = "load-balancer-diagnostics"
  workspace_resource_id     = "log-analytics-id"
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de Load Balancer externo en Azure.