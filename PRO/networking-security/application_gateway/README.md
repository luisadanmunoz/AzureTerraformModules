# Terraform Module: Application Gateway

Este módulo de Terraform crea un Application Gateway en Azure.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_application_gateway.agw`: Crea un Application Gateway con configuración estándar y balanceo de carga en HTTP.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                | Tipo        | Descripción                                           | Por defecto |
|-----------------------|------------|-------------------------------------------------------|------------|
| `name`               | `string`   | Nombre del Application Gateway.                      | -          |
| `resource_group_name` | `string`   | Nombre del grupo de recursos en el que se desplegará.| -          |
| `location`           | `string`   | Ubicación donde se creará el recurso.               | -          |
| `subnet_id`          | `string`   | ID de la subred en la que se desplegará el Gateway.  | -          |
| `public_ip_address_id` | `string` | ID de la IP pública asociada al Gateway.            | -          |
| `private_ip_address`  | `string`   | Dirección IP privada del Gateway.                    | -          |
| `commom_tags`        | `map(any)` | Etiquetas opcionales para el recurso.               | `{}`       |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre  | Descripción                                  |
|---------|----------------------------------------------|
| `id`    | ID del Application Gateway.                |
| `name`  | Nombre del Application Gateway.            |

## Uso

Ejemplo de uso del módulo:

```hcl
module "application_gateway" {
  source               = "./ruta/al/modulo"
  name                 = "mi-application-gateway"
  resource_group_name  = "mi-grupo-de-recursos"
  location             = "East US"
  subnet_id            = "subnet-id"
  public_ip_address_id = "public-ip-id"
  private_ip_address   = "10.0.0.5"
  commom_tags          = { env = "prod" }
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de Application Gateway en Azure.
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
| [azurerm_application_gateway.agw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_commom_tags"></a> [commom\_tags](#input\_commom\_tags) | n/a | `map` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | ############################################################################ APPLICATION GATEWAY VARIABLES ############################################################################ | `string` | n/a | yes |
| <a name="input_private_ip_address"></a> [private\_ip\_address](#input\_private\_ip\_address) | n/a | `string` | n/a | yes |
| <a name="input_public_ip_address_id"></a> [public\_ip\_address\_id](#input\_public\_ip\_address\_id) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ APPLICATION GATEWAY OUTPUT ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->