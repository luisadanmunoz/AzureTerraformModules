# Terraform Module: Route Table

Este módulo de Terraform crea y configura una tabla de rutas en Azure.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_route_table.rt`: Crea una tabla de rutas en Azure.
- `azurerm_route.rt`: Configura dinámicamente rutas dentro de la tabla de rutas.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                  | Tipo        | Descripción                                               | Por defecto |
|-------------------------|------------|-----------------------------------------------------------|------------|
| `name`                  | `string`   | Nombre de la tabla de rutas.                             | -          |
| `location`              | `string`   | Ubicación donde se desplegará la tabla de rutas.         | -          |
| `resource_group_name`   | `string`   | Nombre del grupo de recursos donde se creará la tabla.   | -          |
| `enable_route`          | `bool`     | Habilitar la configuración de rutas en la tabla.         | `false`    |
| `routes`                | `list(object)` | Lista de rutas para la tabla de enrutamiento.          | `[]`       |

Cada objeto en `routes` debe contener:

- `name`: Nombre de la ruta.
- `address_prefix`: Prefijo de dirección de la ruta.
- `next_hop_type`: Tipo de siguiente salto (`VirtualAppliance`, `Internet`, etc.).
- `next_hop_in_ip_address`: Dirección IP del siguiente salto si es un Virtual Appliance.

## Outputs

Este módulo expone los siguientes outputs:

| Nombre  | Descripción                        |
|---------|------------------------------------|
| `id`    | ID de la tabla de rutas.          |
| `name`  | Nombre de la tabla de rutas.      |

## Uso

Ejemplo de uso del módulo:

```hcl
module "route_table" {
  source                = "./ruta/al/modulo"
  name                  = "mi-route-table"
  location              = "East US"
  resource_group_name   = "mi-grupo-de-recursos"
  enable_route          = true
  routes = [
    {
      name                   = "default-route"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.0.0.1"
    }
  ]
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de tablas de rutas en Azure.
