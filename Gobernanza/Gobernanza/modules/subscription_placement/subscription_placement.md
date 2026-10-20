# Módulo Terraform: Subscription Placement

Asocia una **suscripción** a un **Management Group**.

## Cuándo usarlo

- cuando una suscripción debe moverse a la jerarquía objetivo de gobernanza
- cuando quieres separar la creación del management group de la asociación de suscripciones

## Recurso Terraform

- `azurerm_management_group_subscription_association`

## SKU

- no aplica

## Restricciones relevantes

- la suscripción y el management group deben existir previamente
- este recurso es especialmente sensible en despliegues con permisos incompletos

## Entradas relevantes

- `management_group_id`
- `subscription_id`

## Fuente de referencia

- Terraform Registry: `azurerm_management_group_subscription_association`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_subscription_association
