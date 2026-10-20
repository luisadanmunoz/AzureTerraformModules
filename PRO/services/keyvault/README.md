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
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_private_endpoint.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_location"></a> [location](#input\_location) | n/a | `map` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | ############################################################################ KEY VAULT VARIABLES ############################################################################ | `map` | `{}` | no |
| <a name="input_object_id_01"></a> [object\_id\_01](#input\_object\_id\_01) | n/a | `map` | `{}` | no |
| <a name="input_private_dns_zone_ids"></a> [private\_dns\_zone\_ids](#input\_private\_dns\_zone\_ids) | n/a | `map` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `map` | `{}` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | n/a | `map` | `{}` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ############################################################################ KEY VAULT - PRIVATE ENDPOINT ############################################################################ | `map` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | n/a | `map` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ KEY VAULT OUTPUTS ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->