# Terraform Module: Palo Alto VM-Series Firewall

Este módulo de Terraform despliega una máquina virtual con Palo Alto VM-Series Firewall en Azure.

## Recursos

Este módulo define los siguientes recursos:

- `random_password.pass_palo_01`: Genera una contraseña aleatoria para Palo Alto.
- `azurerm_key_vault_secret.keyvault_secret_01`: Almacena la contraseña en Azure Key Vault.
- `azurerm_network_interface.FW1_MGMT_nic`: Configura la interfaz de administración del firewall.
- `azurerm_network_interface.FW1_TST_nic`: Configura la interfaz de red de confianza (Trust).
- `azurerm_network_interface.FW1_UNT_nic`: Configura la interfaz de red no confiable (Untrust).
- `azurerm_virtual_machine.VM_FW1`: Crea la máquina virtual Palo Alto VM-Series.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                          | Tipo        | Descripción                                             | Por defecto |
|---------------------------------|------------|---------------------------------------------------------|------------|
| `keyvault_name`                 | `string`   | Nombre del Key Vault donde se almacenará la contraseña. | -          |
| `keyvault_resourcegroup_name`   | `string`   | Nombre del grupo de recursos del Key Vault.            | -          |
| `keyvault_secret_name_01`       | `string`   | Nombre del secreto en Key Vault.                       | -          |
| `vnet_name_01`                  | `string`   | Nombre de la red virtual de Palo Alto.                 | -          |
| `vnet_resourcegroup_01`         | `string`   | Grupo de recursos de la red virtual.                   | -          |
| `subnet_name_01`                | `string`   | Nombre de la subred de administración.                 | -          |
| `subnet_name_02`                | `string`   | Nombre de la subred de confianza (Trust).              | -          |
| `subnet_name_03`                | `string`   | Nombre de la subred no confiable (Untrust).            | -          |
| `interface_name_01`             | `string`   | Nombre de la interfaz de administración.               | -          |
| `interface_name_02`             | `string`   | Nombre de la interfaz de confianza (Trust).            | -          |
| `interface_name_03`             | `string`   | Nombre de la interfaz no confiable (Untrust).          | -          |
| `interface_privateip_allocation_01` | `string` | Asignación de IP para la interfaz de administración.    | -          |
| `interface_privateip_allocation_02` | `string` | Asignación de IP para la interfaz de confianza.        | -          |
| `interface_privateip_allocation_03` | `string` | Asignación de IP para la interfaz no confiable.        | -          |
| `vm_name_01`                    | `string`   | Nombre de la máquina virtual Palo Alto.               | -          |
| `vm_size_01`                    | `string`   | Tamaño de la máquina virtual.                         | -          |
| `vm_osdisk_name_01`              | `string`   | Nombre del disco del sistema operativo.               | -          |
| `vm_image_publisher_01`          | `string`   | Publicador de la imagen de Palo Alto.                | -          |
| `vm_image_offer_01`              | `string`   | Oferta de la imagen de Palo Alto.                    | -          |
| `vm_image_sku_01`                | `string`   | SKU de la imagen de Palo Alto.                       | -          |
| `vm_image_version_01`            | `string`   | Versión de la imagen de Palo Alto.                   | -          |
| `zones`                          | `string`   | Zona de disponibilidad para la VM.                   | -          |
| `tags`                           | `map(any)` | Etiquetas opcionales para los recursos.              | `{}`       |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre  | Descripción                                  |
|---------|----------------------------------------------|
| `id`    | ID de la interfaz de red no confiable.     |
| `name`  | Nombre de la interfaz de red no confiable. |

## Uso

Ejemplo de uso del módulo:

```hcl
module "palo_alto" {
  source                      = "./ruta/al/modulo"
  keyvault_name               = "mi-keyvault"
  keyvault_resourcegroup_name = "mi-grupo-de-recursos"
  keyvault_secret_name_01     = "paloalto-secret"
  vnet_name_01                = "mi-vnet"
  vnet_resourcegroup_01       = "mi-grupo-de-recursos"
  subnet_name_01              = "mgmt-subnet"
  subnet_name_02              = "trust-subnet"
  subnet_name_03              = "untrust-subnet"
  interface_name_01           = "fw-mgmt-nic"
  interface_name_02           = "fw-trust-nic"
  interface_name_03           = "fw-untrust-nic"
  vm_name_01                  = "fw-instance"
  vm_size_01                  = "Standard_D3_v2"
  vm_osdisk_name_01           = "fw-os-disk"
  vm_image_publisher_01       = "paloaltonetworks"
  vm_image_offer_01           = "vmseries-flex"
  vm_image_sku_01             = "byol"
  vm_image_version_01         = "11.0.401"
  zones                       = "1"
  tags                        = { env = "prod" }
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.
- Aceptar los términos de Palo Alto con:
  ```sh
  az vm image terms accept --urn paloaltonetworks:vmseries-flex:byol:11.0.401
  ```

## Autor

Este módulo ha sido desarrollado para la implementación de Palo Alto VM-Series Firewall en Azure.
