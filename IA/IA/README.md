# IA Azure con Terraform

Catalogo reusable de recursos de IA para Azure siguiendo el mismo patron que `Networking`, `Gobernanza`, `Seguridad`, `Almacenamiento`, `Compute`, `Kubernetes` y `Containers`.

## Modulos incluidos

- `rg`
- `ai_services`
- `ai_foundry`
- `ai_foundry_project`
- `cognitive_account`
- `cognitive_account_project`
- `cognitive_account_customer_managed_key`
- `cognitive_account_rai_policy`
- `cognitive_account_rai_blocklist`
- `cognitive_deployment`
- `machine_learning_workspace`
- `machine_learning_compute_cluster`
- `machine_learning_compute_instance`
- `machine_learning_inference_cluster`
- `machine_learning_datastore_blobstorage`
- `machine_learning_datastore_datalake_gen2`
- `machine_learning_datastore_fileshare`
- `machine_learning_synapse_spark`
- `machine_learning_workspace_network_outbound_rule_fqdn`
- `machine_learning_workspace_network_outbound_rule_private_endpoint`
- `machine_learning_workspace_network_outbound_rule_service_tag`

## Estrategia de uso

- usa `*_name` cuando la dependencia nace dentro de este mismo stack
- usa `*_id` cuando el recurso es externo o cuando quieres ejecutar un ejemplo standalone
- usa `cognitive_account` para Azure OpenAI, Azure AI Foundry moderno y otros servicios cognitivos
- usa `cognitive_account_project` cuando `cognitive_account.kind = "AIServices"` y `project_management_enabled = true`
- usa `cognitive_deployment` para desplegar modelos dentro de una cuenta cognitiva
- usa `cognitive_account_rai_policy` y `cognitive_account_rai_blocklist` para controles de seguridad y gobierno
- usa `ai_services` cuando quieras una cuenta AI Services dedicada
- usa `ai_foundry` y `ai_foundry_project` solo para escenarios legacy de hub clasico
- usa `machine_learning_workspace` como recurso base para Azure Machine Learning
- usa `machine_learning_compute_cluster`, `machine_learning_compute_instance`, `machine_learning_inference_cluster` y `machine_learning_synapse_spark` cuando el workspace ya exista en el mismo plan o aportes su id
- usa `machine_learning_datastore_*` para registrar almacenes de datos en AML
- usa `machine_learning_workspace_network_outbound_rule_*` cuando el workspace use `managed_network` y necesites abrir salidas controladas

## Dependencias habituales

- `ai_foundry` y `machine_learning_workspace` suelen depender de `key_vault_id`, `storage_account_id`, `application_insights_id` o `container_registry_id`, normalmente externos a este stack
- `machine_learning_inference_cluster` depende de un `kubernetes_cluster_id` ya existente, normalmente creado en el stack de `Kubernetes`
- `machine_learning_synapse_spark` depende de un `synapse_spark_pool_id` existente
- `machine_learning_datastore_*` dependen de ids directos de contenedores o shares de storage
- `machine_learning_workspace_network_outbound_rule_private_endpoint` depende del `service_resource_id` del servicio de destino

## Notas practicas

- `cognitive_account_project` requiere que la cuenta cognitiva tenga `kind = "AIServices"`, `project_management_enabled = true`, identidad y `custom_subdomain_name`
- `cognitive_account` y `ai_services` soportan `network_acls`, pero eso obliga a pensar bien `custom_subdomain_name` y la conectividad privada
- `cognitive_deployment.model.format`, nombre y version dependen de la region y de la cuota disponible
- `machine_learning_workspace` requiere `application_insights_id`, `key_vault_id`, `storage_account_id` e `identity`
- `machine_learning_compute_cluster.scale_settings` es obligatorio
- `machine_learning_inference_cluster` adjunta un AKS existente; no crea el cluster
- `machine_learning_synapse_spark` enlaza un Spark Pool de Synapse ya existente; no crea Synapse
- las reglas `machine_learning_workspace_network_outbound_rule_*` tienen sentido cuando el workspace trabaja con `managed_network.isolation_mode = "AllowOnlyApprovedOutbound"`
- `ai_foundry` y `ai_foundry_project` son recursos legacy frente al camino moderno basado en `cognitive_account`
