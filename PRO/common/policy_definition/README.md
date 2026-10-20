# Terraform Module: Policy Definition

Este módulo de Terraform define y asigna políticas en Azure Management Groups.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_policy_definition.policy_definition`: Crea una definición de política en Azure.
- `azurerm_management_group_policy_assignment.management_group_policy_assignment`: Asigna la política a un grupo de administración en Azure.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                 | Tipo         | Descripción                                                         | Por defecto |
|------------------------|-------------|---------------------------------------------------------------------|------------|
| `name`                | `string`    | Nombre de la definición de política.                               | -          |
| `policy_type`         | `string`    | Tipo de política (BuiltIn, Custom, etc.).                          | -          |
| `description`         | `string`    | Descripción de la política.                                        | -          |
| `mode`                | `string`    | Modo de la política (All, Indexed, etc.).                          | -          |
| `display_name`        | `string`    | Nombre para mostrar de la política.                                | -          |
| `management_group_id` | `string`    | ID del grupo de administración en Azure.                           | -          |
| `policy_rule`         | `string`    | Regla de la política en formato JSON.                              | -          |
| `location`            | `string`    | Ubicación para la asignación de la política.                       | -          |
| `identity`            | `bool`      | Indica si se debe utilizar una identidad asignada por el usuario.  | -          |
| `identity_ids`        | `set(string)` | Lista de IDs de identidades asignadas por el usuario, si aplica.   | -          |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre             | Descripción                                      |
|-------------------|------------------------------------------------|
| `id_definition`   | ID de la definición de política creada.       |
| `name_definition` | Nombre de la definición de política.          |
| `id_assignment`   | ID de la asignación de política.              |
| `name_assignment` | Nombre de la asignación de política.          |

## Uso

Ejemplo de uso del módulo:

```hcl
module "policy_definition" {
  source               = "./ruta/al/modulo"
  name                 = "example-policy"
  policy_type          = "Custom"
  description          = "Ejemplo de política personalizada"
  mode                 = "All"
  display_name         = "Example Policy"
  management_group_id  = "management-group-id"
  policy_rule          = <<EOT
{
  "if": {
    "field": "location",
    "equals": "westeurope"
  },
  "then": {
    "effect": "deny"
  }
}
EOT
  location             = "West Europe"
  identity             = true
  identity_ids         = ["/subscriptions/sub-id/resourceGroups/rg-name/providers/Microsoft.ManagedIdentity/userAssignedIdentities/identity-name"]
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la creación y asignación de políticas en Azure Management Groups.

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
| [azurerm_management_group_policy_assignment.management_group_policy_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment) | resource |
| [azurerm_policy_definition.policy_definition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_description"></a> [description](#input\_description) | value of the description tag | `string` | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | value of the display name tag | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input\_identity) | value of the identity tag | `bool` | n/a | yes |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | value of the identity ids tag | `set(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | value of the location tag | `string` | n/a | yes |
| <a name="input_management_group_id"></a> [management\_group\_id](#input\_management\_group\_id) | value of the management group id tag | `map` | `{}` | no |
| <a name="input_mode"></a> [mode](#input\_mode) | value of the mode tag | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | value of the name tag | `string` | n/a | yes |
| <a name="input_policy_rule"></a> [policy\_rule](#input\_policy\_rule) | value of the policy rule tag | `string` | n/a | yes |
| <a name="input_policy_type"></a> [policy\_type](#input\_policy\_type) | value of the policy type tag | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id_assignment"></a> [id\_assignment](#output\_id\_assignment) | value of the id tag |
| <a name="output_id_definition"></a> [id\_definition](#output\_id\_definition) | value of the id tag |
| <a name="output_name_assignment"></a> [name\_assignment](#output\_name\_assignment) | value of the name tag |
| <a name="output_name_definition"></a> [name\_definition](#output\_name\_definition) | value of the name tag |
<!-- END_TF_DOCS -->