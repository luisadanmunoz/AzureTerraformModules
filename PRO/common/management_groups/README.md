# Terraform Module: Management Groups

Este módulo de Terraform gestiona la jerarquía de grupos de administración en Azure.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_management_group.Intermediate_Root`: Grupo de administración raíz intermedio.
- `azurerm_management_group.Platform`: Grupo de administración para la plataforma.
- `azurerm_management_group.Identity`: Grupo de administración para la identidad.
- `azurerm_management_group.Management`: Grupo de administración para la gestión.
- `azurerm_management_group.Connectivity`: Grupo de administración para la conectividad.
- `azurerm_management_group.Landing_Zones`: Grupo de administración para las zonas de aterrizaje.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                               | Tipo         | Descripción                                               | Por defecto |
|--------------------------------------|-------------|-----------------------------------------------------------|------------|
| `name_management_group_Intermediate_Root` | `string`  | Nombre del grupo de administración raíz intermedio.       | -          |
| `subscription_ids_Intermediate_Root` | `set(string)` | Lista de suscripciones asociadas al grupo raíz.          | `null`     |
| `name_management_group_Platform`    | `string`    | Nombre del grupo de administración para la plataforma.   | -          |
| `subscription_ids_Platform`         | `set(string)` | Lista de suscripciones asociadas al grupo de plataforma. | `null`     |
| `name_management_group_Identity`    | `string`    | Nombre del grupo de administración para identidad.       | -          |
| `subscription_ids_Identity`         | `set(string)` | Lista de suscripciones asociadas al grupo de identidad.  | `null`     |
| `name_management_group_Management`  | `string`    | Nombre del grupo de administración para gestión.         | -          |
| `subscription_ids_Management`       | `set(string)` | Lista de suscripciones asociadas al grupo de gestión.   | `null`     |
| `name_management_group_Connectivity` | `string`    | Nombre del grupo de administración para conectividad.    | -          |
| `subscription_ids_Connectivity`     | `set(string)` | Lista de suscripciones asociadas al grupo de conectividad. | `null`     |
| `name_management_group_Landing_Zones` | `string`    | Nombre del grupo de administración para zonas de aterrizaje. | -      |
| `subscription_ids_Landing_Zones`    | `set(string)` | Lista de suscripciones asociadas al grupo de zonas de aterrizaje. | `null` |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre  | Descripción                                           |
|---------|-------------------------------------------------------|
| `id`   | ID del grupo de administración de la plataforma.     |
| `name` | Nombre del grupo de administración de la plataforma. |

## Uso

Ejemplo de uso del módulo:

```hcl
module "management_groups" {
  source                                  = "./ruta/al/modulo"
  name_management_group_Intermediate_Root = "Intermediate Root"
  subscription_ids_Intermediate_Root      = ["sub1", "sub2"]
  name_management_group_Platform          = "Platform"
  subscription_ids_Platform               = ["sub3"]
  name_management_group_Identity          = "Identity"
  subscription_ids_Identity               = ["sub4"]
  name_management_group_Management        = "Management"
  subscription_ids_Management             = ["sub5"]
  name_management_group_Connectivity      = "Connectivity"
  subscription_ids_Connectivity           = ["sub6"]
  name_management_group_Landing_Zones     = "Landing Zones"
  subscription_ids_Landing_Zones          = ["sub7"]
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de grupos de administración en Azure.
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
| [azurerm_management_group.Connectivity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.Identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.Intermediate_Root](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.Landing_Zones](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.Management](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.Platform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/management_group) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_name_management_group_Connectivity"></a> [name\_management\_group\_Connectivity](#input\_name\_management\_group\_Connectivity) | value of the name tag | `string` | n/a | yes |
| <a name="input_name_management_group_Identity"></a> [name\_management\_group\_Identity](#input\_name\_management\_group\_Identity) | value of the name tag | `string` | n/a | yes |
| <a name="input_name_management_group_Intermediate_Root"></a> [name\_management\_group\_Intermediate\_Root](#input\_name\_management\_group\_Intermediate\_Root) | value of the name tag | `string` | n/a | yes |
| <a name="input_name_management_group_Landing_Zones"></a> [name\_management\_group\_Landing\_Zones](#input\_name\_management\_group\_Landing\_Zones) | value of the name tag | `string` | n/a | yes |
| <a name="input_name_management_group_Management"></a> [name\_management\_group\_Management](#input\_name\_management\_group\_Management) | value of the name tag | `string` | n/a | yes |
| <a name="input_name_management_group_Platform"></a> [name\_management\_group\_Platform](#input\_name\_management\_group\_Platform) | value of the name tag | `string` | n/a | yes |
| <a name="input_subscription_ids_Connectivity"></a> [subscription\_ids\_Connectivity](#input\_subscription\_ids\_Connectivity) | value of the subscription id tag | `set(string)` | `null` | no |
| <a name="input_subscription_ids_Identity"></a> [subscription\_ids\_Identity](#input\_subscription\_ids\_Identity) | value of the subscription id tag | `set(string)` | `null` | no |
| <a name="input_subscription_ids_Intermediate_Root"></a> [subscription\_ids\_Intermediate\_Root](#input\_subscription\_ids\_Intermediate\_Root) | value of the subscription id tag | `set(string)` | `null` | no |
| <a name="input_subscription_ids_Landing_Zones"></a> [subscription\_ids\_Landing\_Zones](#input\_subscription\_ids\_Landing\_Zones) | value of the subscription id tag | `set(string)` | `null` | no |
| <a name="input_subscription_ids_Management"></a> [subscription\_ids\_Management](#input\_subscription\_ids\_Management) | value of the subscription id tag | `set(string)` | `null` | no |
| <a name="input_subscription_ids_Platform"></a> [subscription\_ids\_Platform](#input\_subscription\_ids\_Platform) | value of the subscription id tag | `set(string)` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Management Group. |
| <a name="output_name"></a> [name](#output\_name) | value of the name tag |
<!-- END_TF_DOCS -->