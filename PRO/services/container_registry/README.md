# Terraform Module: Azure Container Registry (ACR)

Este módulo de Terraform crea y configura un Azure Container Registry (ACR) con integración de Private Endpoint en Azure.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_container_registry.acr`: Crea un registro de contenedores en Azure.
- `azurerm_private_endpoint.private_endpoint`: Configura un Private Endpoint para el ACR.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                  | Tipo        | Descripción                                                      | Por defecto |
|-------------------------|------------|------------------------------------------------------------------|------------|
| `name`                  | `string`   | Nombre del Azure Container Registry.                           | -          |
| `resource_group_name`   | `string`   | Nombre del grupo de recursos donde se creará el ACR.           | -          |
| `location`              | `string`   | Ubicación donde se desplegará el ACR.                          | -          |
| `subnet_id`             | `string`   | ID de la subred donde se configurará el Private Endpoint.      | -          |
| `private_dns_zone_ids`  | `string`   | ID de la zona DNS privada asociada.                            | -          |
| `tags`                  | `map(any)` | Etiquetas opcionales para el recurso.                          | `{}`       |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre  | Descripción                                  |
|---------|----------------------------------------------|
| `id`    | ID del Azure Container Registry.           |
| `name`  | Nombre del Azure Container Registry.       |

## Uso

Ejemplo de uso del módulo:

```hcl
module "acr" {
  source                = "./ruta/al/modulo"
  name                  = "mi-acr"
  resource_group_name   = "mi-grupo-de-recursos"
  location              = "East US"
  subnet_id             = "subnet-id"
  private_dns_zone_ids  = "dns-zone-id"
  tags                  = { env = "prod" }
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de Azure Container Registry con integración de Private Endpoint en Azure.
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
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_private_endpoint.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | ############################################################################ CONTAINER REGISTRY ############################################################################ | `string` | n/a | yes |
| <a name="input_private_dns_zone_ids"></a> [private\_dns\_zone\_ids](#input\_private\_dns\_zone\_ids) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ############################################################################ CONTAINER REGISTRY - PRIVATE ENDPOINT ############################################################################ | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ CONTAINER REGISTRY - OUTPUT ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->