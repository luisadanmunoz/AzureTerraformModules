# Terraform Module: Network Security Group (NSG) y Reglas de Seguridad

Este módulo de Terraform crea un Network Security Group (NSG) en Azure para controlar el tráfico de red entrante y saliente, además de configurar reglas de seguridad específicas.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_network_security_group.nsg`: Crea un Network Security Group con la configuración especificada.
- `azurerm_network_security_rule.network_security_rule`: Crea una regla de seguridad asociada al NSG.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                                     | Tipo           | Descripción                                                        | Por defecto |
|--------------------------------------------|---------------|--------------------------------------------------------------------|------------|
| `name`                                     | `string`      | Nombre del Network Security Group.                               | -          |
| `location`                                 | `string`      | Ubicación donde se creará el NSG.                                | -          |
| `resource_group_name`                      | `string`      | Nombre del grupo de recursos en el que se desplegará.            | -          |
| `tags`                                     | `map(any)`    | Etiquetas opcionales para el recurso.                            | `{}`       |
| `name_rule`                                | `string`      | Nombre de la regla de seguridad.                                 | -          |
| `direction`                                | `string`      | Dirección del tráfico (`Inbound` o `Outbound`).                   | -          |
| `access`                                   | `string`      | Acción de la regla (`Allow` o `Deny`).                           | -          |
| `priority`                                 | `string`      | Prioridad de la regla de seguridad.                              | -          |
| `protocol`                                 | `string`      | Protocolo a utilizar (`TCP`, `UDP`, `*`).                         | -          |
| `source_port_range`                        | `string`      | Rango de puertos de origen.                                      | -          |
| `source_port_ranges`                       | `set(string)` | Lista de rangos de puertos de origen.                           | -          |
| `destination_port_range`                   | `string`      | Rango de puertos de destino.                                     | -          |
| `destination_port_ranges`                  | `set(string)` | Lista de rangos de puertos de destino.                          | -          |
| `source_address_prefix`                    | `string`      | Prefijo de dirección de origen.                                 | -          |
| `source_address_prefixes`                  | `set(string)` | Lista de prefijos de direcciones de origen.                     | -          |
| `destination_address_prefix`               | `string`      | Prefijo de dirección de destino.                                | -          |
| `destination_address_prefixes`             | `set(string)` | Lista de prefijos de direcciones de destino.                    | -          |
| `source_application_security_group_ids`    | `set(string)` | Lista de IDs de grupos de seguridad de aplicaciones de origen.  | -          |
| `destination_application_security_group_ids` | `set(string)` | Lista de IDs de grupos de seguridad de aplicaciones de destino. | -          |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre  | Descripción                                  |
|---------|----------------------------------------------|
| `nsg_id`   | ID del Network Security Group.          |
| `nsg_name` | Nombre del Network Security Group.      |
| `rule_name` | Nombre de la regla de seguridad creada. |

## Uso

Ejemplo de uso del módulo:

```hcl
module "nsg" {
  source              = "./ruta/al/modulo"
  name                = "mi-nsg"
  location            = "East US"
  resource_group_name = "mi-grupo-de-recursos"
  tags               = { env = "prod" }
  name_rule          = "allow-ssh"
  direction          = "Inbound"
  access            = "Allow"
  priority          = 100
  protocol          = "TCP"
  source_port_range = "*"
  destination_port_range = "22"
  source_address_prefix = "*"
  destination_address_prefix = "10.0.0.0/16"
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de Network Security Groups y reglas de seguridad en Azure.
