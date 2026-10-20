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
| [azurerm_lb.lbe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |
| [azurerm_lb_backend_address_pool.lbe_backend_address_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_lb_probe.lbe_probe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe) | resource |
| [azurerm_lb_rule.lb_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule) | resource |
| [azurerm_monitor_diagnostic_setting.diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_network_interface_backend_address_pool_association.nic-pa-hub-01-nic-untrust](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_backend_address_pool_association) | resource |
| [azurerm_network_interface_backend_address_pool_association.nic-pa-hub-02-nic-untrust](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_backend_address_pool_association) | resource |
| [azurerm_monitor_diagnostic_categories.diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_backend_address_pool_ids"></a> [backend\_address\_pool\_ids](#input\_backend\_address\_pool\_ids) | ############################################################################ LOAD BALANCER - RULE ############################################################################ | `list(string)` | n/a | yes |
| <a name="input_ip_configuration_name_01"></a> [ip\_configuration\_name\_01](#input\_ip\_configuration\_name\_01) | n/a | `string` | n/a | yes |
| <a name="input_ip_configuration_name_02"></a> [ip\_configuration\_name\_02](#input\_ip\_configuration\_name\_02) | n/a | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | ############################################################################ LOAD BALANCER VARIABLES ############################################################################ | `string` | n/a | yes |
| <a name="input_name_diagnostic_setting"></a> [name\_diagnostic\_setting](#input\_name\_diagnostic\_setting) | ############################################################################ LOAD BALANCER - DIAGNOSTIC SETTINGS ############################################################################ | `string` | n/a | yes |
| <a name="input_name_ip"></a> [name\_ip](#input\_name\_ip) | n/a | `string` | n/a | yes |
| <a name="input_network_interface_id_01"></a> [network\_interface\_id\_01](#input\_network\_interface\_id\_01) | ############################################################################ LOAD BALANCER - BACKEND ############################################################################ | `string` | n/a | yes |
| <a name="input_network_interface_id_02"></a> [network\_interface\_id\_02](#input\_network\_interface\_id\_02) | n/a | `string` | n/a | yes |
| <a name="input_public_ip_address_id"></a> [public\_ip\_address\_id](#input\_public\_ip\_address\_id) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | `{}` | no |
| <a name="input_workspace_resource_id"></a> [workspace\_resource\_id](#input\_workspace\_resource\_id) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->