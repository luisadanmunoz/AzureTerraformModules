# Módulo Terraform: Security Center Workspace

Enlaza un `scope` de Microsoft Defender for Cloud con un `Log Analytics Workspace`.

## Recursos Terraform

- `azurerm_security_center_workspace`

## Entradas relevantes

- `scope`
- `workspace_id`

## Restricciones y notas

- `scope` suele ser una suscripción, aunque debe alinearse con el alcance soportado por Defender for Cloud
- el `workspace_id` debe apuntar a un `Log Analytics Workspace` existente
- este recurso es útil para centralizar datos de seguridad en un workspace concreto
- SKU: no aplica

## Fuente de referencia

- Terraform Registry: `azurerm_security_center_workspace`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_workspace
