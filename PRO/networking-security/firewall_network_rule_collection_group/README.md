# Terraform Module: Azure Firewall Policy Rule Collection Group

Este módulo de Terraform crea y configura un grupo de reglas de colección de red en una política de firewall de Azure.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_firewall_policy_rule_collection_group.firewall_network_rule_collection_group`: Crea un grupo de reglas de red dentro de una política de firewall de Azure.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                                | Tipo           | Descripción                                                  | Por defecto |
|---------------------------------------|---------------|--------------------------------------------------------------|------------|
| `name`                                | `string`      | Nombre del grupo de reglas de la política de firewall.      | -          |
| `firewall_policy_id`                  | `string`      | ID de la política de firewall a la que se aplicará.         | -          |
| `priority`                            | `string`      | Prioridad del grupo de reglas dentro de la política.        | -          |
| `name_network_rule_collection`        | `string`      | Nombre de la colección de reglas de red.                    | -          |
| `priority_network_rule_collection`    | `string`      | Prioridad de la colección de reglas de red.                 | -          |
| `action`                              | `string`      | Acción a aplicar en la colección de reglas (`Allow` o `Deny`). | -      |
| `name_rule`                           | `string`      | Nombre de la regla de red dentro de la colección.           | -          |
| `protocols`                           | `list(string)` | Lista de protocolos a permitir (`TCP`, `UDP`, etc.).        | -          |
| `source_addresses`                    | `list(string)` | Lista de direcciones IP de origen.                          | -          |
| `destination_addresses`               | `list(string)` | Lista de direcciones IP de destino.                         | -          |
| `destination_ports`                   | `list(string)` | Lista de puertos de destino permitidos.                     | -          |

## Uso

Ejemplo de uso del módulo:

```hcl
module "firewall_network_rule_collection_group" {
  source                            = "./ruta/al/modulo"
  name                              = "network-rule-group"
  firewall_policy_id                = "firewall-policy-id"
  priority                          = "100"
  name_network_rule_collection      = "network-collection"
  priority_network_rule_collection  = "200"
  action                            = "Allow"
  name_rule                         = "permit-web"
  protocols                         = ["TCP"]
  source_addresses                  = ["10.0.0.0/16"]
  destination_addresses             = ["192.168.1.1"]
  destination_ports                 = ["80", "443"]
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de reglas de red en una política de firewall en Azure.
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
| [azurerm_firewall_policy_rule_collection_group.firewall_network_rule_collection_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_policy_rule_collection_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_action"></a> [action](#input\_action) | n/a | `string` | n/a | yes |
| <a name="input_destination_addresses"></a> [destination\_addresses](#input\_destination\_addresses) | n/a | `list(string)` | n/a | yes |
| <a name="input_destination_ports"></a> [destination\_ports](#input\_destination\_ports) | n/a | `list(string)` | n/a | yes |
| <a name="input_firewall_policy_id"></a> [firewall\_policy\_id](#input\_firewall\_policy\_id) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | ############################################################################ AZURE FIREWALL POLICY RULE COLLECTION GROUP VARIABLES ############################################################################ | `string` | n/a | yes |
| <a name="input_name_network_rule_collection"></a> [name\_network\_rule\_collection](#input\_name\_network\_rule\_collection) | n/a | `string` | n/a | yes |
| <a name="input_name_rule"></a> [name\_rule](#input\_name\_rule) | n/a | `string` | n/a | yes |
| <a name="input_priority"></a> [priority](#input\_priority) | n/a | `string` | n/a | yes |
| <a name="input_priority_network_rule_collection"></a> [priority\_network\_rule\_collection](#input\_priority\_network\_rule\_collection) | n/a | `string` | n/a | yes |
| <a name="input_protocols"></a> [protocols](#input\_protocols) | n/a | `list(string)` | n/a | yes |
| <a name="input_source_addresses"></a> [source\_addresses](#input\_source\_addresses) | n/a | `list(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->