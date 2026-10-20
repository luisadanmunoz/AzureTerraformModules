# Módulo Terraform: Digital Twins Instance

Despliega una `Digital Twins Instance` como base del dominio Digital Twins.

## Recursos Terraform

- `azurerm_digital_twins_instance`

## Restricciones y notas

- si `identity.type` incluye `UserAssigned`, debes informar `identity_ids`

## Outputs principales

- `id`
- `name`
- `host_name`

## Fuente de referencia

- Terraform Registry: `azurerm_digital_twins_instance`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/digital_twins_instance
