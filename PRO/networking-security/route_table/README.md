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
| [azurerm_route_table.rt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_enable_route"></a> [enable\_route](#input\_enable\_route) | Habilitar rutas en la tabla de enrutamiento | `bool` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | ############################################################################ ROUTE TABLE VARIABLES ############################################################################ | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_routes"></a> [routes](#input\_routes) | Lista de rutas para la tabla de enrutamiento | <pre>list(object({<br/>    name                   = string<br/>    address_prefix         = string<br/>    next_hop_type          = string<br/>    next_hop_in_ip_address = string<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ ROUTE TABLE OUTPUT ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->