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