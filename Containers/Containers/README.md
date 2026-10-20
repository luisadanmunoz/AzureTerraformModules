# Containers Azure con Terraform

Catalogo base de Azure Container Apps siguiendo la misma estructura que `Networking`, `Gobernanza`, `Seguridad`, `Almacenamiento`, `Compute` y `Kubernetes`.

## Modulos incluidos

- `rg`
- `log_analytics_workspace`
- `container_app_environment`
- `container_app_environment_storage`
- `container_app_environment_dapr_component`
- `container_app_environment_certificate`
- `container_app_environment_custom_domain`
- `container_app`
- `container_app_custom_domain`
- `container_app_job`

## Estrategia de uso

- usa `*_name` cuando la dependencia nace dentro de este mismo stack
- usa `*_id` cuando el recurso es externo o cuando quieres ejecutar un ejemplo standalone
- arranca por `rg`
- usa `log_analytics_workspace` cuando quieras que el entorno de Container Apps quede listo para observabilidad desde el mismo plan
- usa `container_app_environment` como recurso base del stack
- usa `container_app_environment_storage` cuando quieras montar Azure Files o NFS dentro de tus apps o jobs
- usa `container_app_environment_dapr_component` cuando necesites state store, pubsub, bindings o cualquier componente Dapr compartido por el entorno
- usa `container_app_environment_certificate` y `container_app_environment_custom_domain` cuando quieras gobernar certificados y sufijos DNS a nivel de entorno
- usa `container_app` para workloads HTTP, TCP o background con revisionado
- usa `container_app_custom_domain` cuando quieras asociar dominios a una app concreta
- usa `container_app_job` para procesos batch, manuales, programados o disparados por eventos

## Dependencias habituales

- `container_app_environment` puede depender de `log_analytics_workspace` si `logs_destination = "log-analytics"`
- `container_app_environment_storage` depende de un storage account y share existentes, normalmente externos a este stack
- `container_app_environment_certificate` puede depender de un secreto o certificado existente en Key Vault si eliges `certificate_key_vault`
- `container_app_custom_domain` suele depender de DNS externo y, si no usas certificado gestionado, de `container_app_environment_certificate`

## Notas practicas

- `container_app_environment` necesita `log_analytics_workspace_id` cuando `logs_destination = "log-analytics"`
- `internal_load_balancer_enabled` y `zone_redundancy_enabled` solo tienen sentido con `infrastructure_subnet_id`
- `container_app` y `container_app_job` permiten secretos inline o referenciados desde Key Vault
- en `container_app`, las reglas de trafico de `ingress.traffic_weight` deben sumar `100`
- en `container_app_job`, solo puede existir un trigger entre `manual_trigger_config`, `event_trigger_config` y `schedule_trigger_config`
- para ejemplos standalone, varios `env/*.dev.tfvars` usan ids o valores dummy con formato valido para que `plan` funcione sin depender de recursos reales desplegados
