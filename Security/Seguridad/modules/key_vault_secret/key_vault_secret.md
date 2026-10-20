# Módulo Terraform: Key Vault Secret

Despliega un `Secret` dentro de un `Key Vault` de Azure.

## Recursos Terraform

- `azurerm_key_vault_secret`

## Entradas relevantes

- `key_vault_secret_name`
- `key_vault_id`
- `value`
- `value_wo`
- `value_wo_version`
- `content_type`

## Restricciones y notas

- el módulo exige exactamente uno entre `value` y `value_wo`
- si usas `value_wo`, debes informar también `value_wo_version`
- el Key Vault de destino debe existir y permitir operaciones sobre secretos
- no se expone el valor del secreto como output del módulo
- SKU: no aplica al secreto; depende del Key Vault

## Fuente de referencia

- Terraform Registry: `azurerm_key_vault_secret`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret
