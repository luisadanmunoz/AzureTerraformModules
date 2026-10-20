# Terraform Module: Policy Assignment

Este módulo de Terraform asigna políticas a grupos de administración en Azure.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_management_group_policy_assignment.policy_assignment`: Asigna una política o conjunto de políticas a un grupo de administración en Azure.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                 | Tipo         | Descripción                                                                     | Por defecto |
|------------------------|-------------|---------------------------------------------------------------------------------|------------|
| `name`                | `string`    | Nombre de la asignación de política.                                           | -          |
| `policy_definition_id` | `string`    | ID de la definición de la política o conjunto de políticas a asignar.          | `null`     |
| `management_group_id`  | `string`    | ID del grupo de administración en Azure.                                       | -          |
| `location`            | `string`    | Ubicación de la asignación de política.                                        | -          |
| `display_name`        | `string`    | Nombre para mostrar de la asignación de política.                              | -          |
| `description`         | `string`    | Descripción de la asignación de política.                                      | -          |
| `parameters`          | `map(any)`  | Parámetros opcionales para la política.                                        | `{}`       |
| `policy_type`         | `string`    | Tipo de política (`definition` para una única política o `set_definition` para un conjunto). | `definition` |
| `identity`            | `bool`      | Indica si se debe utilizar una identidad asignada por el usuario.              | -          |
| `identity_ids`        | `set(string)` | Lista de IDs de identidades asignadas por el usuario, si `identity` es `true`.  | -          |

## Uso

Ejemplo de uso del módulo:

```hcl
module "policy_assignment" {
  source                = "./ruta/al/modulo"
  name                  = "example-policy-assignment"
  policy_definition_id  = "policy-id"
  management_group_id   = "management-group-id"
  location              = "West Europe"
  display_name          = "Example Policy"
  description           = "Ejemplo de asignación de política"
  parameters            = {}
  policy_type           = "definition"
  identity              = true
  identity_ids          = ["/subscriptions/sub-id/resourceGroups/rg-name/providers/Microsoft.ManagedIdentity/userAssignedIdentities/identity-name"]
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la asignación de políticas en Azure Management Groups.

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
| [azurerm_management_group_policy_assignment.policy_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_description"></a> [description](#input\_description) | value of the description tag | `string` | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | value of the display name tag | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input\_identity) | value of the identity tag | `bool` | n/a | yes |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | value of the identity ids tag | `set(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | value of the location tag | `string` | n/a | yes |
| <a name="input_management_group_id"></a> [management\_group\_id](#input\_management\_group\_id) | value of the management group id tag | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | value of the name tag | `string` | n/a | yes |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | value of the parameters tag | `map` | `{}` | no |
| <a name="input_policy_definition_id"></a> [policy\_definition\_id](#input\_policy\_definition\_id) | value of the policy definition id tag | `string` | `null` | no |
| <a name="input_policy_type"></a> [policy\_type](#input\_policy\_type) | Tipo de política: 'definition' para una política única o 'set\_definition' para un conjunto de políticas | `string` | `"definition"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->