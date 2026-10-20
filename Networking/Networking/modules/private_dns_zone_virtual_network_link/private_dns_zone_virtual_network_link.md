# Módulo Terraform: Private DNS Zone Virtual Network Link

Vincula una `Private DNS Zone` con una `Virtual Network` de Azure.

## Cuándo usarlo

- cuando necesitas resolución privada desde una VNet hacia servicios con `Private Endpoint`
- cuando quieres habilitar `registration_enabled` para zonas privadas de resolución interna, como laboratorios o cargas IaaS

## Entradas relevantes

- `private_dns_zone_name`: nombre de la zona privada existente o creada en este stack
- `virtual_network_id`: ID de la VNet que se vincula
- `registration_enabled`: en Azure solo debe activarse cuando quieras auto-registro DNS; no es habitual en zonas `privatelink.*`

## Restricciones y notas

- una misma VNet puede enlazarse a varias zonas, pero debes revisar el diseño de nombres para evitar solapes
- para zonas `privatelink.*` lo normal es `registration_enabled = false`
- SKU: no aplica

## Fuente de referencia

- Terraform Registry: `azurerm_private_dns_zone_virtual_network_link`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link
