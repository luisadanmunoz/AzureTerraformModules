# Terraform Module: Azure AD Invitation

Este módulo de Terraform gestiona invitaciones de usuario en Azure Active Directory, incluyendo la asignación a grupos.

## Recursos

Este módulo define los siguientes recursos:

- `azuread_invitation.invitation`: Envía una invitación a un usuario externo para unirse al inquilino de Azure AD.
- `azuread_group_member.member`: Agrega al usuario invitado a un grupo de Azure AD.
- `data.azuread_user.invited_user`: Obtiene información sobre el usuario invitado.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                | Tipo        | Descripción                                                  | Por defecto |
|-----------------------|------------|--------------------------------------------------------------|------------|
| `user_display_name`   | `string`   | Nombre para mostrar del usuario invitado.                   | -          |
| `user_email_address`  | `string`   | Dirección de correo electrónico del usuario invitado.       | -          |
| `user_principal_name` | `string`   | Nombre principal del usuario en Azure AD.                   | -          |
| `group_object_id`     | `string`   | Identificador del grupo en Azure AD al que se agregará el usuario. | -          |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre | Descripción                                  |
|--------|----------------------------------------------|
| `id`   | ID del grupo de Azure AD al que se ha agregado el usuario invitado. |

## Uso

Ejemplo de uso del módulo:

```hcl
module "azuread_invitation" {
  source              = "./ruta/al/modulo"
  user_display_name   = "Juan Pérez"
  user_email_address  = "juan.perez@example.com"
  user_principal_name = "juan.perez"
  group_object_id     = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azuread` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de invitaciones en Azure Active Directory.
