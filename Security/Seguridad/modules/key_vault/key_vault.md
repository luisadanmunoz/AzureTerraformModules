# Módulo Terraform: Key Vault

Despliega un `Key Vault` de Azure con controles opcionales de red y políticas de acceso inline.

## Recursos Terraform

- `azurerm_key_vault`

## Entradas relevantes

- `key_vault_name`
- `resource_group_name`
- `location`
- `tenant_id`
- `sku_name`
- `rbac_authorization_enabled`
- `network_acls`
- `access_policies`

## Restricciones y notas

- `rbac_authorization_enabled` y `access_policies` responden a modelos de autorización distintos; conviene definir uno de forma consciente
- `network_acls.virtual_network_subnet_ids` espera IDs de subnets ya existentes
- `purge_protection_enabled` suele ser recomendable en entornos corporativos porque endurece la protección frente a borrado
- SKU: `standard` o `premium`

## Fuente de referencia

- Terraform Registry: `azurerm_key_vault`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault
