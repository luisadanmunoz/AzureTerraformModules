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

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azuread_group_member.member](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |
| [azuread_invitation.invitation](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/invitation) | resource |
| [azuread_user.invited_user](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_group_object_id"></a> [group\_object\_id](#input\_group\_object\_id) | value of the group object id | `string` | n/a | yes |
| <a name="input_user_display_name"></a> [user\_display\_name](#input\_user\_display\_name) | value of the user display name | `string` | n/a | yes |
| <a name="input_user_email_address"></a> [user\_email\_address](#input\_user\_email\_address) | value of the user email address | `string` | n/a | yes |
| <a name="input_user_principal_name"></a> [user\_principal\_name](#input\_user\_principal\_name) | value of the user principal name | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | value of the azuread invitation id |
<!-- END_TF_DOCS -->