# Módulo Terraform: Policy Exemption

Despliega una **exención de política** en Azure para un assignment existente.

## Recursos Terraform

- `azurerm_management_group_policy_exemption`
- `azurerm_subscription_policy_exemption`
- `azurerm_resource_group_policy_exemption`
- `azurerm_resource_policy_exemption`

## SKU

- no aplica

## Categorías habituales

- `Waiver`
- `Mitigated`

## Entradas relevantes

- `scope_type`
- `scope_id`
- `policy_exemption_name`
- `policy_assignment_id`
- `exemption_category`
- `expires_on`

## Recomendaciones y notas

- usa fecha de expiración cuando sea posible
- documenta la causa y el propietario de la excepción
- una exención no elimina la política; solo excluye su evaluación en el scope indicado
- SKU: no aplica

## Fuente de referencia

- Terraform Registry: `azurerm_management_group_policy_exemption`, `azurerm_subscription_policy_exemption`, `azurerm_resource_group_policy_exemption` y `azurerm_resource_policy_exemption`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_exemption
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_exemption
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_exemption
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_policy_exemption
