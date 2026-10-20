# Módulo Terraform: Private Endpoint

Despliega un `Private Endpoint` de Azure con `private_service_connection` y grupo DNS opcional.

## Cuándo usarlo

- cuando quieres publicar un servicio PaaS o un recurso compatible solo por red privada
- cuando necesitas integrar resolución DNS privada con `Private DNS Zone`

## Entradas relevantes

- `subnet_id`: subnet donde se crea la interfaz del endpoint
- `custom_network_interface_name`: nombre custom de la NIC si quieres gobernar mejor el naming
- `private_service_connection_name`: override opcional del nombre del bloque de conexión
- `private_connection_resource_id`: ID del recurso de destino
- `subresource_names`: subrecursos expuestos por el servicio, por ejemplo `blob`, `sqlServer` o similares
- `is_manual_connection`: útil cuando el flujo requiere aprobación manual
- `private_dns_zone_ids`: zonas DNS privadas opcionales para resolución automática

## Restricciones y notas

- el valor de `subresource_names` depende del servicio de destino y debe coincidir con lo soportado por ese recurso
- si activas `is_manual_connection`, el alta puede requerir aprobación posterior
- la integración DNS no sustituye al diseño de red; debes tener conectividad hacia la subnet del endpoint
- SKU: no aplica

## Fuente de referencia

- Terraform Registry: `azurerm_private_endpoint`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint
