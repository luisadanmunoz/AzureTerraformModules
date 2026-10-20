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