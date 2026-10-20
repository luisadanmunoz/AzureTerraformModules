# Terraform Module: NAT Gateway

Este módulo de Terraform crea y configura un NAT Gateway en Azure para la gestión del tráfico de salida desde una red virtual.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_nat_gateway.nat_gateway`: Crea un NAT Gateway en Azure.
- `azurerm_nat_gateway_public_ip_prefix_association.nat_gateway_public_ip_prefix_association`: Asocia un prefijo de IP pública al NAT Gateway.
- `azurerm_subnet_nat_gateway_association.subnet_nat_gateway_association_2`: Asocia el NAT Gateway a una subred específica.
- `azurerm_public_ip_prefix.public_ip_prefix`: Crea un prefijo de IP pública para el NAT Gateway.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                  | Tipo        | Descripción                                                      | Por defecto |
|-------------------------|------------|------------------------------------------------------------------|------------|
| `name`                  | `string`   | Nombre del NAT Gateway.                                         | -          |
| `location`              | `string`   | Ubicación donde se desplegará el NAT Gateway.                   | -          |
| `resource_group_name`   | `string`   | Nombre del grupo de recursos donde se creará el NAT Gateway.    | -          |
| `tags`                  | `map(any)` | Etiquetas opcionales para el recurso.                           | `{}`       |
| `subnet_id_2`           | `string`   | ID de la segunda subred a la que se asociará el NAT Gateway.    | -          |

## Outputs

Este módulo no define outputs específicos.

## Uso

Ejemplo de uso del módulo:

```hcl
module "nat_gateway" {
  source                = "./ruta/al/modulo"
  name                  = "mi-nat-gateway"
  location              = "East US"
  resource_group_name   = "mi-grupo-de-recursos"
  tags                  = { env = "prod" }
  subnet_id_2           = "subnet-id"
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de NAT Gateway en Azure.
