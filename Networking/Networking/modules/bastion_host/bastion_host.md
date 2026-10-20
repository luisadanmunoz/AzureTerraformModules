# Módulo Terraform: Bastion Host

Despliega un `Azure Bastion Host` para acceso seguro a máquinas virtuales sin exponer RDP o SSH a Internet.

## Cuándo usarlo

- cuando necesitas acceso administrativo seguro a VMs en VNets privadas
- cuando quieres evitar IPs públicas en las máquinas

## Entradas relevantes

- `subnet_id`: debe apuntar a una subnet dedicada llamada `AzureBastionSubnet`
- `public_ip_id`: Azure Bastion necesita una IP pública dedicada
- `sku`: normalmente `Standard` para capacidades modernas
- `scale_units`: capacidad de la instancia

## Restricciones y notas

- la subnet `AzureBastionSubnet` debe existir previamente y cumplir el tamaño mínimo recomendado por Azure
- no reutilices una subnet de aplicaciones
- revisa que la `Public IP` sea compatible y esté en la misma región
- el provider `azurerm` soporta los SKU `Basic`, `Developer`, `Standard` y `Premium`
- `Basic` tiene un conjunto de capacidades más limitado; en entornos corporativos suele encajar mejor `Standard` o superior
- SKU: `Basic`, `Developer`, `Standard` y `Premium`

## Fuente de referencia

- Terraform Registry: `azurerm_bastion_host`
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bastion_host
