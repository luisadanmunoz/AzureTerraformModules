# IoT Azure con Terraform

Catalogo base de Azure IoT y Digital Twins siguiendo la misma estructura que `Networking`, `Gobernanza`, `Seguridad`, `Almacenamiento`, `Compute`, `Kubernetes`, `Containers`, `IA` y `VDI`.

## Modulos incluidos

- `rg`
- `iothub`
- `iothub_shared_access_policy`
- `iothub_certificate`
- `iothub_consumer_group`
- `iothub_device_update_account`
- `iothub_device_update_instance`
- `iothub_dps`
- `iothub_dps_certificate`
- `iothub_dps_shared_access_policy`
- `iothub_endpoint_storage_container`
- `iothub_endpoint_eventhub`
- `iothub_endpoint_servicebus_queue`
- `iothub_endpoint_servicebus_topic`
- `iothub_endpoint_cosmosdb_account`
- `iothub_route`
- `iothub_enrichment`
- `iothub_fallback_route`
- `iothub_file_upload`
- `digital_twins_instance`
- `digital_twins_endpoint_eventgrid`
- `digital_twins_endpoint_eventhub`
- `digital_twins_endpoint_servicebus`
- `digital_twins_time_series_database_connection`

## Estrategia de uso

- usa `*_name` cuando la dependencia nace dentro de este mismo stack
- usa `*_id` cuando el recurso es externo o cuando quieres ejecutar un ejemplo standalone
- arranca por `rg`
- usa `iothub` como recurso base y deja endpoints, rutas, enriquecimientos, fallback route y file upload en recursos separados
- usa `iothub_dps` cuando necesites Device Provisioning Service y deja sus certificados y shared access policies en recursos separados
- usa `iothub_device_update_account` e `iothub_device_update_instance` cuando quieras Azure Device Update integrado con un IoT Hub
- usa `digital_twins_instance` como base de Azure Digital Twins y añade endpoints o time series connections en recursos dedicados

## Dependencias habituales

- `iothub_shared_access_policy`, `iothub_certificate`, `iothub_consumer_group`, `iothub_route`, `iothub_enrichment` e `iothub_fallback_route` dependen de `iothub`
- `iothub_file_upload` y los `iothub_endpoint_*` dependen de `iothub` y de recursos externos como Storage, Event Hub, Service Bus o Cosmos DB
- `iothub_device_update_instance` depende de `iothub_device_update_account` y `iothub`
- `iothub_dps_certificate` e `iothub_dps_shared_access_policy` dependen de `iothub_dps`
- `digital_twins_endpoint_*` y `digital_twins_time_series_database_connection` dependen de `digital_twins_instance`

## Notas practicas

- este stack sigue el patron de recursos extraidos de IoT Hub; por eso el modulo `iothub` no expone bloques inline de endpoints, routes, enrichments, fallback route ni file upload
- en los `iothub_endpoint_*`, `authentication_type = "identityBased"` exige `endpoint_uri` y, salvo `storage_container`, tambien `entity_path`
- en `iothub_shared_access_policy` al menos un permiso debe estar activo y `registry_write` requiere `registry_read`
- en `iothub_dps_shared_access_policy` las combinaciones de permisos siguen las restricciones oficiales del provider
- en `digital_twins_time_series_database_connection` los ids y uris de Event Hub y Kusto suelen ser externos a este stack
- para ejemplos standalone, varios `env/*.dev.tfvars` usan ids, keys o connection strings dummy con formato valido para que `plan` funcione sin depender de recursos reales desplegados
