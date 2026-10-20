# Almacenamiento Azure con Terraform

Catálogo base de almacenamiento para Azure siguiendo la misma estructura que `Networking`, `Gobernanza` y `Seguridad`.

## Módulos incluidos

- `rg`
- `storage_account`
- `storage_container`
- `storage_share`
- `storage_queue`
- `storage_table`
- `storage_management_policy`
- `storage_data_lake_gen2_filesystem`
- `netapp_account`
- `netapp_pool`
- `netapp_snapshot_policy`
- `netapp_volume`

## Estrategia de uso

- usa `*_name` cuando la dependencia nace dentro de este mismo stack
- usa `*_id` cuando el recurso es externo o cuando quieres ejecutar un ejemplo standalone
- arranca por `rg`
- añade `storage_account` como recurso base del stack
- usa `storage_container`, `storage_share`, `storage_queue` y `storage_table` cuando la cuenta ya exista en el mismo plan o cuando aportes el nombre o id directo
- usa `storage_management_policy` cuando quieras automatizar tiering y limpieza de blobs
- usa `storage_data_lake_gen2_filesystem` cuando la cuenta tenga `is_hns_enabled = true`
- usa `netapp_account`, `netapp_pool`, `netapp_snapshot_policy` y `netapp_volume` cuando quieras modelar Azure NetApp Files dentro del mismo catálogo
- usa `subnet_id` directo en `netapp_volume`, porque la subred suele vivir en el stack de networking
- usa `network_rules`, `blob_properties`, `queue_properties`, `share_properties`, `identity` y `static_website` sólo cuando realmente los necesites
