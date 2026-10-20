# Terraform Module: Network Security Group (NSG)

Este módulo de Terraform crea un Network Security Group (NSG) en Azure para controlar el tráfico de red entrante y saliente.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_network_security_group.nsg`: Crea un Network Security Group con la configuración especificada.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                | Tipo        | Descripción                                        | Por defecto |
|-----------------------|------------|----------------------------------------------------|------------|
| `name`               | `string`   | Nombre del Network Security Group.               | -          |
| `location`           | `string`   | Ubicación donde se creará el NSG.                | -          |
| `resource_group_name` | `string`   | Nombre del grupo de recursos en el que se desplegará. | -          |
| `tags`               | `map(any)` | Etiquetas opcionales para el recurso.            | `{}`       |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre  | Descripción                                  |
|---------|----------------------------------------------|
| `nsg_id`   | ID del Network Security Group.          |
| `nsg_name` | Nombre del Network Security Group.      |

## Uso

Ejemplo de uso del módulo:

```hcl
module "nsg" {
  source              = "./ruta/al/modulo"
  name                = "mi-nsg"
  location            = "East US"
  resource_group_name = "mi-grupo-de-recursos"
  tags               = { env = "prod" }
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de Network Security Groups en Azure.