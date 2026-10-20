# Azure Linux Virtual Machine Module

Modulo de Terraform para crear Virtual Machines Linux en Azure con soporte para SSH keys, data disks, managed identity, extensiones y boot diagnostics.

## Uso Basico

```hcl
module "vm" {
  source = "../../modules/virtual-machine-linux"

  name                = "vm-web-dev"
  resource_group_name = "rg-compute-dev"
  location            = "westeurope"
  size                = "Standard_B2s"
  subnet_id           = module.subnet.id

  admin_username = "azureadmin"
  admin_ssh_keys = [file("~/.ssh/id_rsa.pub")]
}
```

## Uso con Ubuntu 22.04 LTS

```hcl
module "vm_ubuntu" {
  source = "../../modules/virtual-machine-linux"

  name                = "vm-app-prod"
  resource_group_name = "rg-compute-prod"
  location            = "westeurope"
  size                = "Standard_D2s_v3"
  subnet_id           = module.subnet_app.id
  zone                = "1"  # Availability Zone

  admin_username                  = "azureadmin"
  disable_password_authentication = true
  admin_ssh_keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAA... user@machine"
  ]

  # Ubuntu 22.04 LTS (por defecto)
  source_image_publisher = "Canonical"
  source_image_offer     = "0001-com-ubuntu-server-jammy"
  source_image_sku       = "22_04-lts-gen2"
  source_image_version   = "latest"

  os_disk_storage_account_type = "Premium_LRS"
  os_disk_size_gb              = 64

  tags = {
    Environment = "production"
    Application = "web-server"
  }
}
```

## Uso con Red Hat Enterprise Linux

```hcl
module "vm_rhel" {
  source = "../../modules/virtual-machine-linux"

  name                = "vm-rhel-prod"
  resource_group_name = "rg-compute-prod"
  location            = "westeurope"
  size                = "Standard_D4s_v3"
  subnet_id           = module.subnet_app.id

  admin_username = "azureadmin"
  admin_ssh_keys = [file("~/.ssh/id_rsa.pub")]

  # RHEL 8
  source_image_publisher = "RedHat"
  source_image_offer     = "RHEL"
  source_image_sku       = "8-lvm-gen2"
  source_image_version   = "latest"
}
```

## Uso con Data Disks

```hcl
module "vm_con_discos" {
  source = "../../modules/virtual-machine-linux"

  name                = "vm-database-prod"
  resource_group_name = "rg-database-prod"
  location            = "westeurope"
  size                = "Standard_E4s_v3"
  subnet_id           = module.subnet_db.id
  zone                = "1"

  admin_username = "azureadmin"
  admin_ssh_keys = [file("~/.ssh/id_rsa.pub")]

  # Disco del SO
  os_disk_storage_account_type = "Premium_LRS"
  os_disk_size_gb              = 64
  os_disk_caching              = "ReadWrite"

  # Data disks adicionales
  data_disks = [
    {
      name                 = "vm-database-prod-data01"
      disk_size_gb         = 256
      storage_account_type = "Premium_LRS"
      lun                  = 0
      caching              = "ReadOnly"  # Para datos de lectura frecuente
    },
    {
      name                 = "vm-database-prod-data02"
      disk_size_gb         = 512
      storage_account_type = "Premium_LRS"
      lun                  = 1
      caching              = "None"  # Para logs transaccionales
    },
    {
      name                 = "vm-database-prod-temp"
      disk_size_gb         = 128
      storage_account_type = "StandardSSD_LRS"
      lun                  = 2
      caching              = "ReadWrite"
    }
  ]

  tags = {
    Role = "database"
  }
}
```

## Uso con Managed Identity

```hcl
module "vm_identity" {
  source = "../../modules/virtual-machine-linux"

  name                = "vm-app-prod"
  resource_group_name = "rg-compute-prod"
  location            = "westeurope"
  size                = "Standard_D2s_v3"
  subnet_id           = module.subnet_app.id

  admin_username = "azureadmin"
  admin_ssh_keys = [file("~/.ssh/id_rsa.pub")]

  # System Assigned Identity
  identity_type = "SystemAssigned"
}

# Asignar permisos a la identidad
resource "azurerm_role_assignment" "vm_storage" {
  scope                = module.storage.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = module.vm_identity.principal_id
}

resource "azurerm_role_assignment" "vm_keyvault" {
  scope                = module.key_vault.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = module.vm_identity.principal_id
}
```

## Uso con Cloud-Init

```hcl
module "vm_cloudinit" {
  source = "../../modules/virtual-machine-linux"

  name                = "vm-web-prod"
  resource_group_name = "rg-compute-prod"
  location            = "westeurope"
  size                = "Standard_B2s"
  subnet_id           = module.subnet_web.id

  admin_username = "azureadmin"
  admin_ssh_keys = [file("~/.ssh/id_rsa.pub")]

  # Cloud-init para configuracion inicial
  custom_data = base64encode(<<-EOF
    #cloud-config
    package_update: true
    package_upgrade: true
    packages:
      - nginx
      - docker.io
      - htop
    runcmd:
      - systemctl enable nginx
      - systemctl start nginx
      - usermod -aG docker azureadmin
    EOF
  )
}
```

## Uso con Azure Monitor Agent

```hcl
module "vm_monitoreada" {
  source = "../../modules/virtual-machine-linux"

  name                = "vm-monitoreada-prod"
  resource_group_name = "rg-compute-prod"
  location            = "westeurope"
  size                = "Standard_D2s_v3"
  subnet_id           = module.subnet_app.id

  admin_username = "azureadmin"
  admin_ssh_keys = [file("~/.ssh/id_rsa.pub")]

  identity_type              = "SystemAssigned"  # Requerido para AMA
  enable_azure_monitor_agent = true

  enable_boot_diagnostics            = true
  boot_diagnostics_storage_account_uri = null  # Usar managed storage
}

# Asociar Data Collection Rule
resource "azurerm_monitor_data_collection_rule_association" "vm" {
  name                    = "dcra-${module.vm_monitoreada.name}"
  target_resource_id      = module.vm_monitoreada.id
  data_collection_rule_id = module.log_analytics.data_collection_rule_id
}
```

## Uso con IP Estatica y NSG

```hcl
module "vm_estatica" {
  source = "../../modules/virtual-machine-linux"

  name                = "vm-app-prod"
  resource_group_name = "rg-compute-prod"
  location            = "westeurope"
  size                = "Standard_D2s_v3"
  subnet_id           = module.subnet_app.id

  admin_username = "azureadmin"
  admin_ssh_keys = [file("~/.ssh/id_rsa.pub")]

  # IP privada estatica
  private_ip_address_allocation = "Static"
  private_ip_address            = "10.0.2.10"

  # Asociar NSG a la NIC
  network_security_group_id = module.nsg_app.id
}
```

## Inputs

| Nombre | Descripcion | Tipo | Default | Requerido |
|--------|-------------|------|---------|-----------|
| `name` | Nombre de la VM (2-64 caracteres) | `string` | - | Si |
| `resource_group_name` | Nombre del Resource Group | `string` | - | Si |
| `location` | Region de Azure | `string` | - | Si |
| `size` | Tamano de la VM | `string` | `"Standard_B2s"` | No |
| `zone` | Availability Zone (1, 2, 3) | `string` | `null` | No |
| `subnet_id` | ID de la subnet | `string` | - | Si |

### Autenticacion

| Nombre | Descripcion | Tipo | Default |
|--------|-------------|------|---------|
| `admin_username` | Usuario administrador | `string` | `"azureadmin"` |
| `admin_password` | Password (si no usa SSH) | `string` | `null` |
| `disable_password_authentication` | Deshabilitar password | `bool` | `true` |
| `admin_ssh_keys` | Lista de claves SSH publicas | `list(string)` | `[]` |

### Imagen

| Nombre | Descripcion | Tipo | Default |
|--------|-------------|------|---------|
| `source_image_id` | ID de imagen personalizada | `string` | `null` |
| `source_image_publisher` | Publisher | `string` | `"Canonical"` |
| `source_image_offer` | Offer | `string` | `"0001-com-ubuntu-server-jammy"` |
| `source_image_sku` | SKU | `string` | `"22_04-lts-gen2"` |
| `source_image_version` | Version | `string` | `"latest"` |

### Disco del SO

| Nombre | Descripcion | Tipo | Default |
|--------|-------------|------|---------|
| `os_disk_caching` | Tipo de caching | `string` | `"ReadWrite"` |
| `os_disk_storage_account_type` | Tipo de storage | `string` | `"Premium_LRS"` |
| `os_disk_size_gb` | Tamano en GB | `number` | `null` |
| `disk_encryption_set_id` | ID del Disk Encryption Set | `string` | `null` |

### Data Disks

| Nombre | Descripcion | Tipo | Default |
|--------|-------------|------|---------|
| `data_disks` | Lista de discos adicionales | `list(object)` | `[]` |

### Identidad

| Nombre | Descripcion | Tipo | Default |
|--------|-------------|------|---------|
| `identity_type` | Tipo de identidad | `string` | `"SystemAssigned"` |
| `identity_ids` | IDs de User Assigned | `list(string)` | `[]` |

### Extensiones

| Nombre | Descripcion | Tipo | Default |
|--------|-------------|------|---------|
| `enable_azure_monitor_agent` | Instalar AMA | `bool` | `false` |
| `enable_boot_diagnostics` | Boot diagnostics | `bool` | `true` |
| `boot_diagnostics_storage_account_uri` | URI storage | `string` | `null` |

## Outputs

| Nombre | Descripcion |
|--------|-------------|
| `id` | ID de la VM |
| `name` | Nombre de la VM |
| `private_ip_address` | IP privada |
| `public_ip_address` | IP publica (si existe) |
| `virtual_machine_id` | VMID |
| `identity` | Informacion de identidad |
| `principal_id` | Principal ID de la identidad |
| `network_interface_id` | ID de la NIC |
| `admin_username` | Usuario administrador |
| `data_disk_ids` | IDs de data disks |

## Tamanos de VM Comunes

### Proposito General (Serie B, D)
| Tamano | vCPUs | RAM | Caso de Uso |
|--------|-------|-----|-------------|
| Standard_B1s | 1 | 1 GB | Dev/Test pequeno |
| Standard_B2s | 2 | 4 GB | Dev/Test, Web pequeno |
| Standard_B2ms | 2 | 8 GB | Web, pequenas apps |
| Standard_D2s_v3 | 2 | 8 GB | Produccion pequena |
| Standard_D4s_v3 | 4 | 16 GB | Produccion media |
| Standard_D8s_v3 | 8 | 32 GB | Produccion grande |

### Memoria Optimizada (Serie E)
| Tamano | vCPUs | RAM | Caso de Uso |
|--------|-------|-----|-------------|
| Standard_E2s_v3 | 2 | 16 GB | Bases de datos pequenas |
| Standard_E4s_v3 | 4 | 32 GB | Bases de datos medianas |
| Standard_E8s_v3 | 8 | 64 GB | SAP, SQL Server |

### Computo Optimizado (Serie F)
| Tamano | vCPUs | RAM | Caso de Uso |
|--------|-------|-----|-------------|
| Standard_F2s_v2 | 2 | 4 GB | Batch processing |
| Standard_F4s_v2 | 4 | 8 GB | Web servers |
| Standard_F8s_v2 | 8 | 16 GB | Gaming, analytics |

## Imagenes Comunes

### Ubuntu
```hcl
# Ubuntu 22.04 LTS
source_image_publisher = "Canonical"
source_image_offer     = "0001-com-ubuntu-server-jammy"
source_image_sku       = "22_04-lts-gen2"

# Ubuntu 20.04 LTS
source_image_publisher = "Canonical"
source_image_offer     = "0001-com-ubuntu-server-focal"
source_image_sku       = "20_04-lts-gen2"
```

### Red Hat
```hcl
# RHEL 8
source_image_publisher = "RedHat"
source_image_offer     = "RHEL"
source_image_sku       = "8-lvm-gen2"

# RHEL 9
source_image_publisher = "RedHat"
source_image_offer     = "RHEL"
source_image_sku       = "9-lvm-gen2"
```

### CentOS / AlmaLinux
```hcl
# AlmaLinux 8
source_image_publisher = "almalinux"
source_image_offer     = "almalinux"
source_image_sku       = "8-gen2"
```

### Debian
```hcl
# Debian 11
source_image_publisher = "Debian"
source_image_offer     = "debian-11"
source_image_sku       = "11-gen2"
```

## Tipos de Disco

| Tipo | IOPS Max | Throughput | Caso de Uso |
|------|----------|------------|-------------|
| Standard_LRS | 500 | 60 MB/s | Dev/Test, backups |
| StandardSSD_LRS | 6,000 | 750 MB/s | Web servers |
| Premium_LRS | 20,000 | 900 MB/s | Bases de datos |
| Premium_ZRS | 20,000 | 900 MB/s | HA con zonas |
| UltraSSD_LRS | 160,000 | 4,000 MB/s | SAP HANA |

## Recursos Creados

- `azurerm_network_interface.this` - Network Interface
- `azurerm_network_interface_security_group_association.this` - NSG association (opcional)
- `azurerm_linux_virtual_machine.this` - La VM
- `azurerm_managed_disk.this` - Data disks (por cada disco)
- `azurerm_virtual_machine_data_disk_attachment.this` - Disk attachments
- `azurerm_virtual_machine_extension.ama` - Azure Monitor Agent (opcional)

## Consideraciones de Seguridad

1. **SSH Keys**: Siempre usar SSH keys en lugar de passwords
2. **NSG**: Asociar NSG para controlar trafico
3. **Managed Identity**: Usar identidad para acceder a otros recursos
4. **Encryption**: Considerar disk encryption para datos sensibles
5. **Updates**: Habilitar automatic patching o Azure Update Manager

<!-- BEGIN_TF_DOCS -->
# Azure Linux Virtual Machine Module

Modulo reutilizable para crear VMs Linux en Azure.
Incluye configuracion de discos, identidad, extensiones y boot diagnostics.

## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_linux_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_managed_disk.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_network_interface.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_virtual_machine_data_disk_attachment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_virtual_machine_extension.ama](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Password del administrador (requerido si disable\_password\_authentication es false) | `string` | `null` | no |
| <a name="input_admin_ssh_keys"></a> [admin\_ssh\_keys](#input\_admin\_ssh\_keys) | Lista de claves SSH publicas | `list(string)` | `[]` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Nombre del usuario administrador | `string` | `"azureadmin"` | no |
| <a name="input_boot_diagnostics_storage_account_uri"></a> [boot\_diagnostics\_storage\_account\_uri](#input\_boot\_diagnostics\_storage\_account\_uri) | URI del storage account para boot diagnostics (null para managed) | `string` | `null` | no |
| <a name="input_computer_name"></a> [computer\_name](#input\_computer\_name) | Hostname de la VM (por defecto usa el nombre de la VM) | `string` | `null` | no |
| <a name="input_custom_data"></a> [custom\_data](#input\_custom\_data) | Cloud-init custom data (base64 encoded) | `string` | `null` | no |
| <a name="input_data_disks"></a> [data\_disks](#input\_data\_disks) | Lista de data disks a crear y adjuntar | <pre>list(object({<br/>    name                 = string<br/>    disk_size_gb         = number<br/>    storage_account_type = string<br/>    lun                  = number<br/>    caching              = optional(string, "ReadWrite")<br/>    create_option        = optional(string, "Empty")<br/>  }))</pre> | `[]` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Tags por defecto | `map(string)` | <pre>{<br/>  "ManagedBy": "Terraform"<br/>}</pre> | no |
| <a name="input_disable_password_authentication"></a> [disable\_password\_authentication](#input\_disable\_password\_authentication) | Deshabilitar autenticacion por password | `bool` | `true` | no |
| <a name="input_disk_encryption_set_id"></a> [disk\_encryption\_set\_id](#input\_disk\_encryption\_set\_id) | ID del Disk Encryption Set | `string` | `null` | no |
| <a name="input_enable_azure_monitor_agent"></a> [enable\_azure\_monitor\_agent](#input\_enable\_azure\_monitor\_agent) | Instalar Azure Monitor Agent | `bool` | `false` | no |
| <a name="input_enable_boot_diagnostics"></a> [enable\_boot\_diagnostics](#input\_enable\_boot\_diagnostics) | Habilitar boot diagnostics | `bool` | `true` | no |
| <a name="input_encryption_at_host_enabled"></a> [encryption\_at\_host\_enabled](#input\_encryption\_at\_host\_enabled) | Habilitar encriptacion en el host | `bool` | `false` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | Lista de IDs de identidades asignadas por usuario | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | Tipo de identidad (SystemAssigned, UserAssigned, SystemAssigned,UserAssigned) | `string` | `"SystemAssigned"` | no |
| <a name="input_location"></a> [location](#input\_location) | Region de Azure | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Nombre de la Virtual Machine | `string` | n/a | yes |
| <a name="input_network_security_group_id"></a> [network\_security\_group\_id](#input\_network\_security\_group\_id) | ID del NSG a asociar con la NIC | `string` | `null` | no |
| <a name="input_os_disk_caching"></a> [os\_disk\_caching](#input\_os\_disk\_caching) | Tipo de caching del disco OS | `string` | `"ReadWrite"` | no |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb) | Tamano del disco OS en GB | `number` | `null` | no |
| <a name="input_os_disk_storage_account_type"></a> [os\_disk\_storage\_account\_type](#input\_os\_disk\_storage\_account\_type) | Tipo de storage del disco OS | `string` | `"Premium_LRS"` | no |
| <a name="input_os_disk_write_accelerator_enabled"></a> [os\_disk\_write\_accelerator\_enabled](#input\_os\_disk\_write\_accelerator\_enabled) | Habilitar Write Accelerator | `bool` | `false` | no |
| <a name="input_patch_mode"></a> [patch\_mode](#input\_patch\_mode) | Modo de parcheo (ImageDefault, AutomaticByPlatform) | `string` | `"ImageDefault"` | no |
| <a name="input_private_ip_address"></a> [private\_ip\_address](#input\_private\_ip\_address) | IP privada estatica (requerido si allocation es Static) | `string` | `null` | no |
| <a name="input_private_ip_address_allocation"></a> [private\_ip\_address\_allocation](#input\_private\_ip\_address\_allocation) | Metodo de asignacion de IP privada (Dynamic o Static) | `string` | `"Dynamic"` | no |
| <a name="input_provision_vm_agent"></a> [provision\_vm\_agent](#input\_provision\_vm\_agent) | Instalar el agente de VM | `bool` | `true` | no |
| <a name="input_public_ip_address_id"></a> [public\_ip\_address\_id](#input\_public\_ip\_address\_id) | ID de la IP publica (opcional) | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Nombre del Resource Group | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | Tamano de la VM (ej: Standard\_B2s, Standard\_D2s\_v3) | `string` | `"Standard_B2s"` | no |
| <a name="input_source_image_id"></a> [source\_image\_id](#input\_source\_image\_id) | ID de imagen personalizada (si se usa, ignora source\_image\_reference) | `string` | `null` | no |
| <a name="input_source_image_offer"></a> [source\_image\_offer](#input\_source\_image\_offer) | Offer de la imagen | `string` | `"0001-com-ubuntu-server-jammy"` | no |
| <a name="input_source_image_publisher"></a> [source\_image\_publisher](#input\_source\_image\_publisher) | Publisher de la imagen | `string` | `"Canonical"` | no |
| <a name="input_source_image_sku"></a> [source\_image\_sku](#input\_source\_image\_sku) | SKU de la imagen | `string` | `"22_04-lts-gen2"` | no |
| <a name="input_source_image_version"></a> [source\_image\_version](#input\_source\_image\_version) | Version de la imagen | `string` | `"latest"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ID de la subnet donde se desplegara la VM | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags adicionales | `map(string)` | `{}` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | User data (base64 encoded) | `string` | `null` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Availability Zone (1, 2 o 3) | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_admin_username"></a> [admin\_username](#output\_admin\_username) | Nombre del usuario administrador |
| <a name="output_data_disk_ids"></a> [data\_disk\_ids](#output\_data\_disk\_ids) | IDs de los data disks |
| <a name="output_id"></a> [id](#output\_id) | ID de la Virtual Machine |
| <a name="output_identity"></a> [identity](#output\_identity) | Identidad de la VM |
| <a name="output_name"></a> [name](#output\_name) | Nombre de la Virtual Machine |
| <a name="output_network_interface_id"></a> [network\_interface\_id](#output\_network\_interface\_id) | ID de la Network Interface |
| <a name="output_os_disk_id"></a> [os\_disk\_id](#output\_os\_disk\_id) | ID del disco del sistema operativo |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | Principal ID de la identidad de la VM |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | IP privada de la VM |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | IP publica de la VM (si existe) |
| <a name="output_virtual_machine_id"></a> [virtual\_machine\_id](#output\_virtual\_machine\_id) | Virtual Machine ID (VMID) |
<!-- END_TF_DOCS -->