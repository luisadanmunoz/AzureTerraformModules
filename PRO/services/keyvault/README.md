# Terraform Module: Azure Key Vault

Este módulo de Terraform crea y configura un Azure Key Vault con Private Endpoint y control de acceso mediante RBAC.

## Recursos

Este módulo define los siguientes recursos:

- `azurerm_key_vault.kv`: Crea un Azure Key Vault.
- `azurerm_private_endpoint.private_endpoint`: Configura un Private Endpoint para el Key Vault.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                  | Tipo        | Descripción                                                      | Por defecto |
|-------------------------|------------|------------------------------------------------------------------|------------|
| `name`                  | `string`   | Nombre del Azure Key Vault.                                     | -          |
| `resource_group_name`   | `string`   | Nombre del grupo de recursos donde se creará el Key Vault.     | -          |
| `location`              | `string`   | Ubicación donde se desplegará el Key Vault.                    | -          |
| `tenant_id`             | `string`   | ID del Tenant de Azure Active Directory.                        | -          |
| `sku_name`              | `string`   | SKU del Key Vault (`standard` o `premium`).                    | -          |
| `subnet_id`             | `string`   | ID de la subred donde se configurará el Private Endpoint.      | -          |
| `private_dns_zone_ids`  | `string`   | ID de la zona privada de DNS asociada.                         | -          |
| `tags`                  | `map(any)` | Etiquetas opcionales para el recurso.                          | `{}`       |

## Outputs

Este módulo no define outputs específicos.

## Uso

Ejemplo de uso del módulo:

```hcl
module "keyvault" {
  source                = "./ruta/al/modulo"
  name                  = "mi-keyvault"
  resource_group_name   = "mi-grupo-de-recursos"
  location              = "East US"
  tenant_id             = "tenant-id"
  sku_name              = "standard"
  subnet_id             = "subnet-id"
  private_dns_zone_ids  = "dns-zone-id"
  tags                  = { env = "prod" }
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la gestión de Azure Key Vault con Private Endpoint en Azure.
