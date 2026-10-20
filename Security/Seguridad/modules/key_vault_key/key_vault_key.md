# Módulo Terraform: Key Vault Key

Despliega una `Key` dentro de un `Key Vault` de Azure con política de rotación opcional.

## Recursos Terraform

- `azurerm_key_vault_key`

## Entradas relevantes

- `key_vault_key_name`
- `key_vault_id`
- `key_type`
- `key_size`
- `curve`
- `key_opts`
- `rotation_policy`

## Restricciones y notas

- `key_type`, `key_size` y `curve` deben ser coherentes entre sí según el tipo de clave
- `rotation_policy` es opcional y permite modelar expiración, aviso y rotación automática
- el Key Vault de destino debe existir y permitir la operación de creación de claves
- SKU: no aplica a la clave; depende del Key Vault

## Fuente de referencia

- Terraform Registry: `azurerm_key_vault_key`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key
