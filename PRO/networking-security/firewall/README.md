# Terraform Module: Azure Firewall

Este módulo de Terraform crea y configura un Azure Firewall con una política de firewall asociada.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_firewall.firewall`: Crea un Azure Firewall con configuraciones de red y seguridad.
- `azurerm_firewall_policy.firewall_policy`: Crea una política de firewall para aplicar reglas de seguridad.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                            | Tipo        | Descripción                                             | Por defecto |
|-----------------------------------|------------|---------------------------------------------------------|------------|
| `name`                            | `string`   | Nombre del Azure Firewall.                             | -          |
| `location`                        | `string`   | Ubicación donde se desplegará Azure Firewall.          | -          |
| `resource_group_name`             | `string`   | Nombre del grupo de recursos donde se creará Firewall. | -          |
| `subnet_id`                       | `string`   | ID de la subred donde se desplegará Firewall.          | -          |
| `public_ip_address_id`            | `string`   | ID de la IP pública asociada al Firewall.              | -          |
| `tags`                            | `map(any)` | Etiquetas opcionales para el recurso.                  | `{}`       |
| `management_name`                 | `string`   | Nombre de la configuración de administración.          | -          |
| `subnet_management_id`            | `string`   | ID de la subred de administración.                     | -          |
| `management_public_ip_address_id` | `string`   | ID de la IP pública de administración.                 | -          |
| `name_firewall_policy`            | `string`   | Nombre de la política de firewall asociada.            | -          |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre       | Descripción                                      |
|-------------|------------------------------------------------|
| `id`        | ID del Azure Firewall.                         |
| `name`      | Nombre del Azure Firewall.                     |
| `policy_id` | ID de la política de firewall.                 |
| `policy_name` | Nombre de la política de firewall asociada. |

## Uso

Ejemplo de uso del módulo:

```hcl
module "azure_firewall" {
  source                        = "./ruta/al/modulo"
  name                          = "mi-firewall"
  location                      = "East US"
  resource_group_name           = "mi-grupo-de-recursos"
  subnet_id                     = "subnet-firewall-id"
  public_ip_address_id          = "public-ip-id"
  management_name               = "firewall-management"
  subnet_management_id          = "subnet-management-id"
  management_public_ip_address_id = "public-ip-management-id"
  name_firewall_policy          = "firewall-policy"
  tags                          = { env = "prod" }
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de Azure Firewall en Azure.
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
| [azurerm_firewall.firewall](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall) | resource |
| [azurerm_firewall_policy.firewall_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_management_name"></a> [management\_name](#input\_management\_name) | n/a | `string` | n/a | yes |
| <a name="input_management_public_ip_address_id"></a> [management\_public\_ip\_address\_id](#input\_management\_public\_ip\_address\_id) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | ############################################################################ AZURE FIREWALL VARIABLES ############################################################################ | `string` | n/a | yes |
| <a name="input_name_firewall_policy"></a> [name\_firewall\_policy](#input\_name\_firewall\_policy) | ############################################################################ AZURE FIREWALL POLICY VARIABLES ############################################################################ | `string` | n/a | yes |
| <a name="input_public_ip_address_id"></a> [public\_ip\_address\_id](#input\_public\_ip\_address\_id) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `string` | n/a | yes |
| <a name="input_subnet_management_id"></a> [subnet\_management\_id](#input\_subnet\_management\_id) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ AZURE FIREWALL OUTPUT ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_policy_id"></a> [policy\_id](#output\_policy\_id) | n/a |
| <a name="output_policy_name"></a> [policy\_name](#output\_policy\_name) | n/a |
<!-- END_TF_DOCS -->