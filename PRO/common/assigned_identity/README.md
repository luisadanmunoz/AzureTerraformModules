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
| [azurerm_user_assigned_identity.user_assigned_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_location"></a> [location](#input\_location) | value of the user assigned identity location | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | value of the user assigned identity name | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value of the user assigned identity resource group name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | value of the user assigned identity tags | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | value of the user assigned identity id |
| <a name="output_name"></a> [name](#output\_name) | value of the user assigned identity name |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | value of the user assigned identity principal\_id |
<!-- END_TF_DOCS -->