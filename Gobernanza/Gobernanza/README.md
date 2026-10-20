# Gobernanza Azure con Terraform

Catálogo de módulos Terraform para desplegar capacidades de gobernanza en Azure siguiendo una estructura homogénea:

- llamadas desde el root por tipo de recurso
- módulos desacoplados dentro de `modules/`
- ejemplos de entrada por dominio en `env/`
- referencias internas por `*_name` cuando el recurso lo crea el propio stack
- `*_id` como fallback para integraciones externas o ejemplos aislados

## Estructura

- `versions.tf`: versión mínima de Terraform y provider `azurerm`
- `variables.tf`: contrato tipado del stack root
- `*.tf`: llamadas a módulos por tipo de recurso
- `env/*.tfvars`: ejemplos por módulo y ejemplo integral
- `modules/<modulo>`: implementación de cada módulo con 4 ficheros

## Cómo usarlo

Inicialización:

```powershell
terraform init
```

Validación:

```powershell
terraform validate
```

Plan completo de ejemplo:

```powershell
terraform plan -var-file="env\full.dev.tfvars"
```

## Convenciones

- Usa `*_name` cuando la dependencia la crea este mismo stack.
- Usa `*_id` cuando el recurso ya existe fuera de este estado Terraform o quieres un ejemplo standalone.
- Mantén los nombres cortos en recursos con límites estrictos de Azure, por ejemplo `policy_assignment`.
- Evita hardcodear IDs reales de producción en los ejemplos.
- Usa `tags` globales y solo sobrescribe por recurso cuando sea necesario.

## Módulos incluidos

- `rg`
- `tags`
- `management_group`
- `subscription_placement`
- `role_assignment`
- `resource_lock`
- `diagnostic_settings`
- `budget`
- `policy_definition`
- `policy_set_definition`
- `policy_assignment`
- `policy_exemption`
- `policy_remediation`
- `monitor_action_group`
- `activity_log_alert`
- `resource_provider_registration`

## Resumen de módulos

| Módulo | Finalidad | Dependencias típicas | SKU |
|---|---|---|---|
| `rg` | Crear Resource Groups | Ninguna | No aplica |
| `tags` | Construir mapas de tags | Ninguna | No aplica |
| `management_group` | Crear jerarquía organizativa | Ninguna | No aplica |
| `subscription_placement` | Mover suscripciones a management groups | `management_group` | No aplica |
| `role_assignment` | Asignar RBAC | `rg`, `management_group` o scope externo | No aplica |
| `resource_lock` | Proteger recursos frente a borrado o escritura | `rg` o scope externo | No aplica |
| `diagnostic_settings` | Enviar logs y métricas a destinos de monitorización | Recurso destino externo o existente | No aplica |
| `budget` | Control de gasto | `management_group`, `rg` o suscripción | No aplica |
| `policy_definition` | Definir políticas custom | Ninguna | No aplica |
| `policy_set_definition` | Agrupar políticas en iniciativas | `policy_definition` o IDs externos | No aplica |
| `policy_assignment` | Asignar políticas o iniciativas | `management_group`, `rg`, `policy_definition`, `policy_set_definition` | No aplica |
| `policy_exemption` | Crear excepciones | `policy_assignment` | No aplica |
| `policy_remediation` | Ejecutar remediación | `policy_assignment` | No aplica |
| `monitor_action_group` | Definir destinos de alertas | `rg` | No aplica |
| `activity_log_alert` | Alertar sobre eventos administrativos | `rg`, `monitor_action_group` | No aplica |
| `resource_provider_registration` | Registrar providers en la suscripción | Ninguna | No aplica |

## Orden recomendado de despliegue

1. `resource_provider_registration`
2. `management_group`
3. `subscription_placement`
4. `rg`
5. `tags`
6. `monitor_action_group`
7. `role_assignment`
8. `resource_lock`
9. `diagnostic_settings`
10. `budget`
11. `policy_definition`
12. `policy_set_definition`
13. `policy_assignment`
14. `policy_exemption`
15. `policy_remediation`

## Relación entre `*_name` y `*_id`

- Usa `*_name` cuando el recurso lo crea este mismo catálogo y quieres enlazar módulos internamente.
- Usa `*_id` cuando el recurso existe fuera de este estado, pertenece a otro stack o quieres ejecutar un ejemplo sin dependencias previas.
- Si ambos modelos son posibles, prioriza `*_name` y deja `*_id` como fallback operativo.

## Archivos de ejemplo en `env`

- `00-global.dev.tfvars`: base vacía con todas las colecciones
- `full.dev.tfvars`: ejemplo integral de todo el catálogo
- `*.dev.tfvars`: ejemplo individual por módulo o capacidad

## Estrategia recomendada de uso

1. Comienza con `00-global.dev.tfvars` o con el `*.dev.tfvars` del módulo que quieras probar.
2. Lleva primero a `plan` los recursos base: management groups, resource groups y action groups.
3. Añade después gobierno normativo: policy definitions, initiatives y assignments.
4. Usa `policy_exemption` y `policy_remediation` solo cuando ya exista una necesidad operativa real.

## Notas operativas

- `diagnostic_settings` ya está adaptado a `enabled_metric` para evitar problemas con `azurerm` 5.x.
- `activity_log_alert` requiere `location`.
- `policy_remediation` está ajustado al shape real soportado por `azurerm` 4.x.
- El ejemplo `full.dev.tfvars` valida y genera plan completo actualmente.
