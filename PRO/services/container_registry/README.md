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