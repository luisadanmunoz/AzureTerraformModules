# Seguridad Azure con Terraform

Catálogo base de seguridad para Azure siguiendo la misma estructura que `Networking` y `Gobernanza`.

## Módulos incluidos

- `rg`
- `key_vault`
- `key_vault_access_policy`
- `key_vault_certificate`
- `key_vault_key`
- `key_vault_secret`
- `log_analytics_workspace`
- `monitor_diagnostic_setting`
- `security_center_workspace`
- `security_center_contact`
- `security_center_auto_provisioning`
- `security_center_setting`
- `security_center_server_vulnerability_assessments_setting`
- `security_center_server_vulnerability_assessment_virtual_machine`
- `security_center_subscription_pricing`
- `sentinel_log_analytics_workspace_onboarding`
- `sentinel_watchlist`
- `sentinel_watchlist_item`

## Estrategia de uso

- usa `*_name` cuando la dependencia nace dentro de este mismo stack
- usa `*_id` cuando el recurso es externo o cuando quieres ejecutar un ejemplo standalone
- arranca por `rg`
- añade `key_vault` después con `rbac_authorization_enabled` o `access_policies` según tu modelo de autorización
- usa `key_vault_access_policy` solo si no gestionas `access_policies` inline dentro de `key_vault`
- usa `key_vault_certificate` cuando necesites certificados auto-firmados o importados dentro del mismo vault
- añade `key_vault_key` y `key_vault_secret` cuando el vault ya exista en el mismo plan o cuando aportes el `key_vault_id`
- añade `log_analytics_workspace` como base para Microsoft Defender y Sentinel
- usa `monitor_diagnostic_setting` para enviar auditoría y métricas a Log Analytics, Event Hub o Storage
- usa `security_center_workspace` para enlazar el scope con un workspace de Log Analytics
- usa `security_center_contact`, `security_center_auto_provisioning`, `security_center_setting` y `security_center_server_vulnerability_assessments_setting` para la configuración base de Defender for Cloud
- usa `security_center_server_vulnerability_assessment_virtual_machine` cuando el virtual machine ya exista y quieras activar evaluación de vulnerabilidades sobre él
- usa `security_center_subscription_pricing` para habilitar planes de Defender por tipo de recurso
- usa `sentinel_log_analytics_workspace_onboarding` cuando quieras activar Microsoft Sentinel sobre un workspace
- usa `sentinel_watchlist` y `sentinel_watchlist_item` cuando quieras cargar listas de referencia dentro de Sentinel
- usa `network_acls` cuando necesites restringir acceso por IP o subnets ya existentes
- varios recursos de `security_center_*` operan a nivel de suscripción y requieren permisos elevados como `Owner`
