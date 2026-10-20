# Módulo Terraform: Private DNS Zone

Despliega una `Private DNS Zone` de Azure.

## Cuándo usarlo

- cuando necesitas resolución DNS privada para `Private Endpoints`
- cuando quieres desacoplar la resolución interna de nombres del DNS público

## Entradas relevantes

- `private_dns_zone_name`: nombre DNS de la zona, por ejemplo `privatelink.blob.core.windows.net`
- `resource_group_name`: grupo de recursos donde se crea la zona

## Restricciones y notas

- la zona por sí sola no resuelve desde una VNet hasta que la vinculas con `Private DNS Zone Virtual Network Link`
- para servicios `Private Link` conviene respetar los nombres de zona recomendados por Azure
- SKU: no aplica

## Fuente de referencia

- Terraform Registry: `azurerm_private_dns_zone`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone
