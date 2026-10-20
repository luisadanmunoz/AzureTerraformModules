# Kubernetes Azure con Terraform

Catalogo base de Kubernetes para Azure siguiendo la misma estructura que `Networking`, `Gobernanza`, `Seguridad`, `Almacenamiento` y `Compute`.

## Modulos incluidos

- `rg`
- `kubernetes_cluster`
- `kubernetes_cluster_node_pool`
- `kubernetes_cluster_extension`
- `kubernetes_cluster_trusted_access_role_binding`
- `kubernetes_fleet_manager`
- `kubernetes_fleet_member`
- `kubernetes_fleet_update_strategy`

## Estrategia de uso

- usa `*_name` cuando la dependencia nace dentro de este mismo stack
- usa `*_id` cuando el recurso es externo o cuando quieres ejecutar un ejemplo standalone
- arranca por `rg`
- usa `kubernetes_cluster` para desplegar el cluster base de AKS
- usa `kubernetes_cluster_node_pool` cuando quieras desacoplar pools adicionales del cluster principal
- usa `kubernetes_cluster_extension` para habilitar extensiones de AKS como Flux o Azure Monitor
- usa `kubernetes_cluster_trusted_access_role_binding` cuando necesites trusted access hacia recursos externos
- usa `kubernetes_fleet_manager`, `kubernetes_fleet_member` y `kubernetes_fleet_update_strategy` para escenarios multi-cluster
- usa `vnet_subnet_id`, `pod_subnet_id`, `source_resource_id` y otros ids directos cuando la dependencia viva fuera de este stack
