# Terraform Module: User Assigned Identity

Este módulo de Terraform crea una identidad asignada por el usuario en Azure.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_user_assigned_identity.user_assigned_identity`: Crea una identidad asignada por el usuario en Azure.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                | Tipo        | Descripción                                                         | Por defecto |
|-----------------------|------------|---------------------------------------------------------------------|------------|
| `name`               | `string`   | Nombre de la identidad asignada por el usuario.                    | -          |
| `resource_group_name` | `string`   | Nombre del grupo de recursos donde se creará la identidad.          | -          |
| `location`           | `string`   | Ubicación de la identidad asignada por el usuario.                  | -          |
| `tags`               | `map(any)` | Etiquetas opcionales para la identidad asignada por el usuario.     | `{}`       |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre         | Descripción                                             |
|---------------|---------------------------------------------------------|
| `id`         | ID de la identidad asignada por el usuario.             |
| `name`       | Nombre de la identidad asignada por el usuario.         |
| `principal_id` | ID del principal de la identidad asignada por el usuario. |

## Uso

Ejemplo de uso del módulo:

```hcl
module "user_assigned_identity" {
  source              = "./ruta/al/modulo"
  name                = "mi-identidad"
  resource_group_name = "mi-grupo-de-recursos"
  location            = "East US"
  tags                = { env = "dev" }
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de identidades asignadas por el usuario en Azure.
