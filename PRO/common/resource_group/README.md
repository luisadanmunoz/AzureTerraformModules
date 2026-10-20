# Terraform Module: Resource Group

Este módulo de Terraform crea un grupo de recursos en Azure.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_resource_group.resource_group`: Crea un grupo de recursos en Azure con las configuraciones especificadas.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                | Tipo        | Descripción                                        | Por defecto |
|-----------------------|------------|----------------------------------------------------|------------|
| `resource_group_name` | `string`   | Nombre del grupo de recursos en Azure.           | -          |
| `location`           | `string`   | Ubicación del grupo de recursos en Azure.        | -          |
| `tags`               | `map(any)` | Etiquetas opcionales para el grupo de recursos.  | `{}`       |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre  | Descripción                                  |
|---------|----------------------------------------------|
| `id`    | ID del grupo de recursos en Azure.         |
| `name`  | Nombre del grupo de recursos en Azure.     |

## Uso

Ejemplo de uso del módulo:

```hcl
module "resource_group" {
  source              = "./ruta/al/modulo"
  resource_group_name = "mi-grupo-de-recursos"
  location           = "East US"
  tags               = { env = "dev" }
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de grupos de recursos en Azure.
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
| [azurerm_resource_group.resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_location"></a> [location](#input\_location) | value of the location | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value of the resource group name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | value of the tags | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | value of the id resource group |
| <a name="output_name"></a> [name](#output\_name) | value of the name resource group |
<!-- END_TF_DOCS -->