# VirtualMachine

Terraform module for creating Azure Virtual Machines (Linux and Windows).

## Features

- Linux and Windows VM support
- Automatic NIC and Public IP creation
- Data disk attachment
- Trusted Launch (Secure Boot, vTPM)
- Spot VM support with eviction policies
- Managed Identity (System/User Assigned)
- VM Extensions
- Boot diagnostics
- Availability Set / Zone placement
- Proximity Placement Group support
- Dedicated Host support
- Hybrid Benefit licensing
- Auto-generated admin password

## Usage

### Linux VM with SSH

```hcl
module "linux_vm" {
  source = "./Compute/VirtualMachine"

  resource_group_name = "rg-compute-prod-001"
  location            = "westeurope"
  name                = "vm-linux-prod-001"
  os_type             = "Linux"
  size                = "Standard_D4s_v5"
  subnet_id           = module.subnet.id

  admin_username                  = "adminuser"
  disable_password_authentication = true
  admin_ssh_keys = [{
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }]

  source_image_reference = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  identity = {
    type = "SystemAssigned"
  }
}
```

### Windows VM

```hcl
module "windows_vm" {
  source = "./Compute/VirtualMachine"

  resource_group_name = "rg-compute-prod-001"
  location            = "westeurope"
  name                = "vm-win-prod-001"
  os_type             = "Windows"
  size                = "Standard_D4s_v5"
  subnet_id           = module.subnet.id
  zone                = "1"

  admin_username = "adminuser"
  # Password auto-generated

  source_image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-g2"
    version   = "latest"
  }

  # Trusted Launch
  secure_boot_enabled = true
  vtpm_enabled        = true

  # Data disks
  data_disks = [
    {
      lun          = 0
      disk_size_gb = 128
    },
    {
      lun          = 1
      disk_size_gb = 256
    }
  ]
}

output "admin_password" {
  value     = module.windows_vm.admin_password
  sensitive = true
}
```

### Spot VM

```hcl
module "spot_vm" {
  source = "./Compute/VirtualMachine"

  resource_group_name = "rg-compute-dev-001"
  location            = "westeurope"
  os_type             = "Linux"
  size                = "Standard_D8s_v5"
  subnet_id           = module.subnet.id

  priority        = "Spot"
  eviction_policy = "Deallocate"
  max_bid_price   = 0.5

  admin_username = "adminuser"
  source_image_reference = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |
| random | >= 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether to create the resource | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| name | VM name | `string` | `null` | no |
| os_type | OS type (Linux/Windows) | `string` | n/a | yes |
| size | VM SKU size | `string` | n/a | yes |
| admin_username | Admin username | `string` | n/a | yes |
| admin_password | Admin password | `string` | `null` | no |
| subnet_id | Subnet ID for NIC | `string` | `null` | no |
| source_image_reference | Marketplace image | `object` | `null` | no |
| zone | Availability Zone | `string` | `null` | no |
| identity | Managed Identity config | `object` | `null` | no |
| tags | Tags to assign | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Virtual Machine |
| name | The name of the Virtual Machine |
| private_ip_address | The primary private IP address |
| public_ip_address | The public IP address |
| principal_id | The Principal ID of System Assigned Identity |
| admin_password | The auto-generated admin password |

## Common Image References

### Windows
```hcl
# Windows Server 2022
source_image_reference = {
  publisher = "MicrosoftWindowsServer"
  offer     = "WindowsServer"
  sku       = "2022-datacenter-g2"
}

# Windows 11
source_image_reference = {
  publisher = "MicrosoftWindowsDesktop"
  offer     = "windows-11"
  sku       = "win11-23h2-pro"
}
```

### Linux
```hcl
# Ubuntu 22.04
source_image_reference = {
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-jammy"
  sku       = "22_04-lts-gen2"
}

# RHEL 9
source_image_reference = {
  publisher = "RedHat"
  offer     = "RHEL"
  sku       = "9-lvm-gen2"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0, < 5.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0, < 5.0.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_linux_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_managed_disk.data](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_network_interface.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_virtual_machine_data_disk_attachment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_virtual_machine_extension.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_windows_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [random_password.admin](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | (Optional) The admin password for the VM. Required for Windows, optional for Linux. | `string` | `null` | no |
| <a name="input_admin_ssh_keys"></a> [admin\_ssh\_keys](#input\_admin\_ssh\_keys) | (Optional) List of SSH public keys for Linux VMs.<br/>- username: The username for the SSH key.<br/>- public\_key: The SSH public key. | <pre>list(object({<br/>    username   = string<br/>    public_key = string<br/>  }))</pre> | `[]` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | (Required) The admin username for the VM. | `string` | n/a | yes |
| <a name="input_availability_set_id"></a> [availability\_set\_id](#input\_availability\_set\_id) | (Optional) The ID of the Availability Set. DEPENDENCY: Availability Set must exist. | `string` | `null` | no |
| <a name="input_boot_diagnostics"></a> [boot\_diagnostics](#input\_boot\_diagnostics) | (Optional) Boot diagnostics configuration.<br/>- enabled: Enable boot diagnostics. Default: true.<br/>- storage\_account\_uri: Storage account URI. If null, managed storage is used. | <pre>object({<br/>    enabled             = optional(bool, true)<br/>    storage_account_uri = optional(string, null)<br/>  })</pre> | `{}` | no |
| <a name="input_capacity_reservation_group_id"></a> [capacity\_reservation\_group\_id](#input\_capacity\_reservation\_group\_id) | (Optional) The ID of the Capacity Reservation Group. DEPENDENCY: Capacity Reservation Group must exist. | `string` | `null` | no |
| <a name="input_computer_name"></a> [computer\_name](#input\_computer\_name) | (Optional) The computer name of the VM. Max 15 chars for Windows, 64 for Linux. | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Virtual Machine. | `bool` | `true` | no |
| <a name="input_create_network_interface"></a> [create\_network\_interface](#input\_create\_network\_interface) | (Optional) Create a Network Interface. Default: true if network\_interface\_ids not provided. | `bool` | `true` | no |
| <a name="input_create_public_ip"></a> [create\_public\_ip](#input\_create\_public\_ip) | (Optional) Create a Public IP for the VM. Default: false. | `bool` | `false` | no |
| <a name="input_data_disks"></a> [data\_disks](#input\_data\_disks) | (Optional) List of data disks to attach.<br/>- name: Disk name.<br/>- disk\_size\_gb: Disk size in GB.<br/>- storage\_account\_type: Disk type. Default: Premium\_LRS.<br/>- caching: Caching type. Default: ReadWrite.<br/>- lun: Logical Unit Number.<br/>- create\_option: Create option. Default: Empty. | <pre>list(object({<br/>    name                   = optional(string, null)<br/>    disk_size_gb           = number<br/>    storage_account_type   = optional(string, "Premium_LRS")<br/>    caching                = optional(string, "ReadWrite")<br/>    lun                    = number<br/>    create_option          = optional(string, "Empty")<br/>    disk_encryption_set_id = optional(string, null)<br/>  }))</pre> | `[]` | no |
| <a name="input_dedicated_host_group_id"></a> [dedicated\_host\_group\_id](#input\_dedicated\_host\_group\_id) | (Optional) The ID of the Dedicated Host Group. DEPENDENCY: Dedicated Host Group must exist. | `string` | `null` | no |
| <a name="input_dedicated_host_id"></a> [dedicated\_host\_id](#input\_dedicated\_host\_id) | (Optional) The ID of the Dedicated Host. DEPENDENCY: Dedicated Host must exist. | `string` | `null` | no |
| <a name="input_disable_password_authentication"></a> [disable\_password\_authentication](#input\_disable\_password\_authentication) | (Optional) Disable password auth for Linux VMs. Default: false. | `bool` | `false` | no |
| <a name="input_enable_accelerated_networking"></a> [enable\_accelerated\_networking](#input\_enable\_accelerated\_networking) | (Optional) Enable accelerated networking. Default: true. | `bool` | `true` | no |
| <a name="input_enable_ip_forwarding"></a> [enable\_ip\_forwarding](#input\_enable\_ip\_forwarding) | (Optional) Enable IP forwarding on the NIC. Default: false. | `bool` | `false` | no |
| <a name="input_encryption_at_host_enabled"></a> [encryption\_at\_host\_enabled](#input\_encryption\_at\_host\_enabled) | (Optional) Enable encryption at host. Default: false. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_eviction_policy"></a> [eviction\_policy](#input\_eviction\_policy) | (Optional) Eviction policy for Spot VMs. Values: Deallocate, Delete. | `string` | `null` | no |
| <a name="input_extensions"></a> [extensions](#input\_extensions) | (Optional) List of VM extensions to install.<br/>- name: Extension name.<br/>- publisher: Extension publisher.<br/>- type: Extension type.<br/>- type\_handler\_version: Extension version.<br/>- auto\_upgrade\_minor\_version: Auto upgrade. Default: true.<br/>- settings: JSON settings.<br/>- protected\_settings: JSON protected settings. | <pre>list(object({<br/>    name                       = string<br/>    publisher                  = string<br/>    type                       = string<br/>    type_handler_version       = string<br/>    auto_upgrade_minor_version = optional(bool, true)<br/>    settings                   = optional(string, null)<br/>    protected_settings         = optional(string, null)<br/>  }))</pre> | `[]` | no |
| <a name="input_generate_admin_password"></a> [generate\_admin\_password](#input\_generate\_admin\_password) | (Optional) Generate a random admin password. Default: true if admin\_password not provided. | `bool` | `true` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) Identity configuration.<br/>- type: Type of identity. Values: SystemAssigned, UserAssigned, SystemAssigned, UserAssigned.<br/>- identity\_ids: List of User Assigned Identity IDs. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number for the naming convention. | `string` | `"001"` | no |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | (Optional) License type for hybrid benefit. Values: None, Windows\_Client, Windows\_Server, RHEL\_BYOS, SLES\_BYOS. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Virtual Machine should exist. | `string` | n/a | yes |
| <a name="input_max_bid_price"></a> [max\_bid\_price](#input\_max\_bid\_price) | (Optional) Maximum bid price for Spot VMs. -1 means current on-demand price. | `number` | `-1` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the Virtual Machine. If not provided, a name will be generated. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for the generated name. Default: 'vm'. | `string` | `"vm"` | no |
| <a name="input_network_interface_ids"></a> [network\_interface\_ids](#input\_network\_interface\_ids) | (Optional) List of Network Interface IDs. If not provided, a NIC will be created. DEPENDENCY: NICs must exist. | `list(string)` | `[]` | no |
| <a name="input_os_disk"></a> [os\_disk](#input\_os\_disk) | (Optional) OS disk configuration.<br/>- name: OS disk name.<br/>- caching: Caching type. Values: None, ReadOnly, ReadWrite. Default: ReadWrite.<br/>- storage\_account\_type: Disk type. Default: Premium\_LRS.<br/>- disk\_size\_gb: Disk size in GB.<br/>- disk\_encryption\_set\_id: ID of the Disk Encryption Set.<br/>- write\_accelerator\_enabled: Enable write accelerator. | <pre>object({<br/>    name                      = optional(string, null)<br/>    caching                   = optional(string, "ReadWrite")<br/>    storage_account_type      = optional(string, "Premium_LRS")<br/>    disk_size_gb              = optional(number, null)<br/>    disk_encryption_set_id    = optional(string, null)<br/>    write_accelerator_enabled = optional(bool, false)<br/>  })</pre> | `{}` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | (Required) The OS type for the VM. Values: Linux, Windows. | `string` | n/a | yes |
| <a name="input_patch_assessment_mode"></a> [patch\_assessment\_mode](#input\_patch\_assessment\_mode) | (Optional) Patch assessment mode. Values: ImageDefault, AutomaticByPlatform. | `string` | `null` | no |
| <a name="input_patch_mode"></a> [patch\_mode](#input\_patch\_mode) | (Optional) Patch mode. Windows: Manual, AutomaticByOS, AutomaticByPlatform. Linux: ImageDefault, AutomaticByPlatform. | `string` | `null` | no |
| <a name="input_priority"></a> [priority](#input\_priority) | (Optional) VM priority. Values: Regular, Spot. Default: Regular. | `string` | `"Regular"` | no |
| <a name="input_private_ip_address"></a> [private\_ip\_address](#input\_private\_ip\_address) | (Optional) The private IP address. If not set, Dynamic allocation is used. | `string` | `null` | no |
| <a name="input_private_ip_address_allocation"></a> [private\_ip\_address\_allocation](#input\_private\_ip\_address\_allocation) | (Optional) IP allocation method. Values: Dynamic, Static. Default: Dynamic. | `string` | `"Dynamic"` | no |
| <a name="input_proximity_placement_group_id"></a> [proximity\_placement\_group\_id](#input\_proximity\_placement\_group\_id) | (Optional) The ID of the Proximity Placement Group. DEPENDENCY: PPG must exist. | `string` | `null` | no |
| <a name="input_public_ip_sku"></a> [public\_ip\_sku](#input\_public\_ip\_sku) | (Optional) SKU for the Public IP. Values: Basic, Standard. Default: Standard. | `string` | `"Standard"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_secure_boot_enabled"></a> [secure\_boot\_enabled](#input\_secure\_boot\_enabled) | (Optional) Enable Secure Boot for Trusted Launch. Default: false. | `bool` | `false` | no |
| <a name="input_size"></a> [size](#input\_size) | (Required) The SKU size for the Virtual Machine (e.g., Standard\_D2s\_v5). | `string` | n/a | yes |
| <a name="input_source_image_id"></a> [source\_image\_id](#input\_source\_image\_id) | (Optional) The ID of a custom image or Shared Image Gallery image. DEPENDENCY: Image must exist. | `string` | `null` | no |
| <a name="input_source_image_reference"></a> [source\_image\_reference](#input\_source\_image\_reference) | (Optional) Source image reference from Marketplace.<br/>- publisher: Image publisher.<br/>- offer: Image offer.<br/>- sku: Image SKU.<br/>- version: Image version. Default: latest. | <pre>object({<br/>    publisher = string<br/>    offer     = string<br/>    sku       = string<br/>    version   = optional(string, "latest")<br/>  })</pre> | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Optional) The Subnet ID for the NIC. Required if create\_network\_interface is true. DEPENDENCY: Subnet must exist. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_vtpm_enabled"></a> [vtpm\_enabled](#input\_vtpm\_enabled) | (Optional) Enable vTPM for Trusted Launch. Default: false. | `bool` | `false` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for the naming convention. | `string` | `"app"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | (Optional) The Availability Zone in which the VM should be located. | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | The admin password of the Virtual Machine (if generated). |
| <a name="output_admin_username"></a> [admin\_username](#output\_admin\_username) | The admin username of the Virtual Machine. |
| <a name="output_computer_name"></a> [computer\_name](#output\_computer\_name) | The computer name of the Virtual Machine. |
| <a name="output_data_disk_ids"></a> [data\_disk\_ids](#output\_data\_disk\_ids) | The IDs of the attached data disks. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Virtual Machine. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity block of the Virtual Machine. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Virtual Machine. |
| <a name="output_network_interface_id"></a> [network\_interface\_id](#output\_network\_interface\_id) | The ID of the created Network Interface. |
| <a name="output_os_type"></a> [os\_type](#output\_os\_type) | The OS type of the Virtual Machine. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The Principal ID of the System Assigned Managed Identity. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The primary private IP address of the Virtual Machine. |
| <a name="output_private_ip_addresses"></a> [private\_ip\_addresses](#output\_private\_ip\_addresses) | All private IP addresses of the Virtual Machine. |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The public IP address of the Virtual Machine. |
| <a name="output_public_ip_addresses"></a> [public\_ip\_addresses](#output\_public\_ip\_addresses) | All public IP addresses of the Virtual Machine. |
| <a name="output_size"></a> [size](#output\_size) | The size (SKU) of the Virtual Machine. |
| <a name="output_zone"></a> [zone](#output\_zone) | The Availability Zone of the Virtual Machine. |
<!-- END_TF_DOCS -->