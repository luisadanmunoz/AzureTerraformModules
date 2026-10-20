# Módulo Terraform: Security Center Subscription Pricing

Configura el plan de `Microsoft Defender for Cloud` para un tipo de recurso dentro de la suscripción.

## Recursos Terraform

- `azurerm_security_center_subscription_pricing`

## Entradas relevantes

- `tier`
- `resource_type`
- `subplan`
- `extensions`

## Restricciones y notas

- `resource_type` define el servicio protegido, por ejemplo `VirtualMachines`
- `tier` suele ser `Standard` cuando activas capacidades avanzadas de Defender
- `subplan` y `extensions` dependen del plan concreto que estés activando
- SKU: no aplica

## Fuente de referencia

- Terraform Registry: `azurerm_security_center_subscription_pricing`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_subscription_pricing
