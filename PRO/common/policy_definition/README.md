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
