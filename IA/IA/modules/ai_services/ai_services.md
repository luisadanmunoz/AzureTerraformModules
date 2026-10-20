# Módulo Terraform: AI Services

Despliega una cuenta `AI Services` para servicios multi-modelo y escenarios genéricos de Azure AI.

## Recursos Terraform

- `azurerm_ai_services`

## Entradas relevantes

- `ai_services_name`
- `resource_group_name`
- `location`
- `sku_name`
- `custom_subdomain_name`
- `network_acls`
- `identity`

## Restricciones y notas

- `custom_subdomain_name` es obligatorio si defines `network_acls`
- `customer_managed_key` debe usar exactamente una de las dos claves posibles
- si no defines `custom_subdomain_name`, no podrás usar private endpoint más adelante

## Outputs principales

- `id`
- `name`
- `endpoint`

## Fuente de referencia

- Terraform Registry: `azurerm_ai_services`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/ai_services
