# Terraform Module: Azure AD Group

Este módulo de Terraform crea un grupo en Azure Active Directory.

## Recursos

Este módulo define los siguientes recursos:

- `azuread_group.group`: Crea un grupo en Azure AD con los propietarios especificados.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre      | Tipo         | Descripción                                  | Por defecto |
|------------|-------------|----------------------------------------------|------------|
| `group_name` | `string`  | Nombre del grupo de Azure AD.               | -          |
| `owners`    | `set(string)` | Lista de propietarios del grupo de Azure AD. | -          |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre         | Descripción                                      |
|---------------|--------------------------------------------------|
| `id`         | ID del grupo de Azure AD.                        |
| `display_name` | Nombre para mostrar del grupo de Azure AD.      |

## Uso

Ejemplo de uso del módulo:

```hcl
module "azuread_group" {
  source      = "./ruta/al/modulo"
  group_name  = "mi-grupo"
  owners      = ["user1@example.com", "user2@example.com"]
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azuread` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de grupos en Azure Active Directory.

