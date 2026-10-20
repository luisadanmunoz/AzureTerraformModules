# Módulo Terraform: Cognitive Deployment

Despliega un modelo sobre una `cognitive_account`, especialmente útil para Azure OpenAI y AIServices.

## Recursos Terraform

- `azurerm_cognitive_deployment`

## Entradas relevantes

- `cognitive_account_id`
- `model`
- `sku`
- `rai_policy_name`

## Restricciones y notas

- la disponibilidad de `model.format`, modelo y versión depende de la región y la cuota
- `rai_policy_name` te permite ligar el despliegue a una política de guardrails

## Outputs principales

- `id`
- `name`

## Fuente de referencia

- Terraform Registry: `azurerm_cognitive_deployment`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_deployment
