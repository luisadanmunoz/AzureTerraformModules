# Módulo Terraform: Cognitive Account Customer Managed Key

Asocia una CMK externa a una `cognitive_account`.

## Recursos Terraform

- `azurerm_cognitive_account_customer_managed_key`

## Restricciones y notas

- no mezcles este recurso con el bloque inline `customer_managed_key` del recurso `cognitive_account`
- usa `identity_client_id` cuando la cuenta tenga múltiples identidades y necesites fijar cuál accede a la clave

## Outputs principales

- `id`

## Fuente de referencia

- Terraform Registry: `azurerm_cognitive_account_customer_managed_key`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account_customer_managed_key
