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
