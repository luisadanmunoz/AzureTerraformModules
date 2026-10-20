# VirtualMachineScaleSet

Terraform module for creating Azure Virtual Machine Scale Sets (Linux and Windows).

## Features

- Linux and Windows VMSS support
- Autoscaling with CPU-based rules
- Multi-zone deployment with zone balancing
- Load Balancer and Application Gateway integration
- Data disk support
- Trusted Launch (Secure Boot, vTPM)
- Rolling upgrade support
- Managed Identity
- VM Extensions
- Boot diagnostics

## Usage

### Basic VMSS with Autoscaling

```hcl
module "vmss" {
  source = "./Compute/VirtualMachineScaleSet"

  resource_group_name = "rg-compute-prod-001"
  location            = "westeurope"
  name                = "vmss-web-prod-001"

  os_type   = "Linux"
  sku       = "Standard_D2s_v5"
  instances = 2
  subnet_id = module.subnet.id
  zones     = ["1", "2", "3"]

  admin_username = "adminuser"
  admin_ssh_keys = [{
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }]

  source_image_reference = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
  }

  autoscale = {
    enabled       = true
    min_count     = 2
    max_count     = 10
    default_count = 2
  }

  identity = { type = "SystemAssigned" }
}
```

### Windows VMSS with Load Balancer

```hcl
module "vmss_windows" {
  source = "./Compute/VirtualMachineScaleSet"

  resource_group_name = "rg-compute-prod-001"
  location            = "westeurope"

  os_type   = "Windows"
  sku       = "Standard_D4s_v5"
  instances = 3
  subnet_id = module.subnet.id

  admin_username = "adminuser"

  source_image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-g2"
  }

  load_balancer_backend_address_pool_ids = [
    azurerm_lb_backend_address_pool.web.id
  ]

  health_probe_id = azurerm_lb_probe.http.id
  upgrade_mode    = "Rolling"
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
| create | Controls creation | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| name | VMSS name | `string` | `null` | no |
| os_type | OS type (Linux/Windows) | `string` | n/a | yes |
| sku | VM SKU size | `string` | n/a | yes |
| instances | Instance count | `number` | `2` | no |
| subnet_id | Subnet ID | `string` | n/a | yes |
| zones | Availability Zones | `list(string)` | `[]` | no |
| autoscale | Autoscale config | `object` | `{}` | no |
| identity | Managed Identity | `object` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The VMSS ID |
| name | The VMSS name |
| unique_id | The VMSS unique ID |
| principal_id | System Assigned Identity Principal ID |
| admin_password | Auto-generated admin password |
| autoscale_setting_id | Autoscale Setting ID |

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
| [azurerm_linux_virtual_machine_scale_set.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | resource |
| [azurerm_monitor_autoscale_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_windows_virtual_machine_scale_set.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine_scale_set) | resource |
| [random_password.admin](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | (Optional) The admin password. Required for Windows. | `string` | `null` | no |
| <a name="input_admin_ssh_keys"></a> [admin\_ssh\_keys](#input\_admin\_ssh\_keys) | (Optional) List of SSH public keys for Linux instances. | <pre>list(object({<br/>    username   = string<br/>    public_key = string<br/>  }))</pre> | `[]` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | (Required) The admin username for the instances. | `string` | n/a | yes |
| <a name="input_application_gateway_backend_address_pool_ids"></a> [application\_gateway\_backend\_address\_pool\_ids](#input\_application\_gateway\_backend\_address\_pool\_ids) | (Optional) List of Application Gateway Backend Pool IDs. DEPENDENCY: Backend pools must exist. | `list(string)` | `[]` | no |
| <a name="input_autoscale"></a> [autoscale](#input\_autoscale) | (Optional) Autoscale settings.<br/>- enabled: Enable autoscaling. Default: false.<br/>- min\_count: Minimum instance count.<br/>- max\_count: Maximum instance count.<br/>- default\_count: Default instance count.<br/>- scale\_out\_cpu\_threshold: CPU % to scale out. Default: 75.<br/>- scale\_in\_cpu\_threshold: CPU % to scale in. Default: 25. | <pre>object({<br/>    enabled                 = optional(bool, false)<br/>    min_count               = optional(number, 1)<br/>    max_count               = optional(number, 10)<br/>    default_count           = optional(number, 2)<br/>    scale_out_cpu_threshold = optional(number, 75)<br/>    scale_in_cpu_threshold  = optional(number, 25)<br/>  })</pre> | `{}` | no |
| <a name="input_boot_diagnostics"></a> [boot\_diagnostics](#input\_boot\_diagnostics) | (Optional) Boot diagnostics configuration. | <pre>object({<br/>    enabled             = optional(bool, true)<br/>    storage_account_uri = optional(string, null)<br/>  })</pre> | `{}` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Virtual Machine Scale Set. | `bool` | `true` | no |
| <a name="input_data_disks"></a> [data\_disks](#input\_data\_disks) | (Optional) List of data disks. | <pre>list(object({<br/>    lun                    = number<br/>    disk_size_gb           = number<br/>    storage_account_type   = optional(string, "Premium_LRS")<br/>    caching                = optional(string, "ReadWrite")<br/>    create_option          = optional(string, "Empty")<br/>    disk_encryption_set_id = optional(string, null)<br/>  }))</pre> | `[]` | no |
| <a name="input_disable_password_authentication"></a> [disable\_password\_authentication](#input\_disable\_password\_authentication) | (Optional) Disable password auth for Linux. Default: false. | `bool` | `false` | no |
| <a name="input_enable_accelerated_networking"></a> [enable\_accelerated\_networking](#input\_enable\_accelerated\_networking) | (Optional) Enable accelerated networking. Default: true. | `bool` | `true` | no |
| <a name="input_encryption_at_host_enabled"></a> [encryption\_at\_host\_enabled](#input\_encryption\_at\_host\_enabled) | (Optional) Enable encryption at host. Default: false. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_extensions"></a> [extensions](#input\_extensions) | (Optional) List of VM extensions. | <pre>list(object({<br/>    name                       = string<br/>    publisher                  = string<br/>    type                       = string<br/>    type_handler_version       = string<br/>    auto_upgrade_minor_version = optional(bool, true)<br/>    settings                   = optional(string, null)<br/>    protected_settings         = optional(string, null)<br/>  }))</pre> | `[]` | no |
| <a name="input_generate_admin_password"></a> [generate\_admin\_password](#input\_generate\_admin\_password) | (Optional) Generate a random admin password. Default: true. | `bool` | `true` | no |
| <a name="input_health_probe_id"></a> [health\_probe\_id](#input\_health\_probe\_id) | (Optional) The ID of a Load Balancer Health Probe for rolling upgrades. DEPENDENCY: Health Probe must exist. | `string` | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) Identity configuration. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number for the naming convention. | `string` | `"001"` | no |
| <a name="input_instances"></a> [instances](#input\_instances) | (Optional) Number of VM instances. Default: 2. | `number` | `2` | no |
| <a name="input_load_balancer_backend_address_pool_ids"></a> [load\_balancer\_backend\_address\_pool\_ids](#input\_load\_balancer\_backend\_address\_pool\_ids) | (Optional) List of Load Balancer Backend Pool IDs. DEPENDENCY: Backend pools must exist. | `list(string)` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the VMSS should exist. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the VMSS. If not provided, a name will be generated. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for the generated name. Default: 'vmss'. | `string` | `"vmss"` | no |
| <a name="input_os_disk"></a> [os\_disk](#input\_os\_disk) | (Optional) OS disk configuration.<br/>- caching: Caching type. Default: ReadWrite.<br/>- storage\_account\_type: Disk type. Default: Premium\_LRS.<br/>- disk\_size\_gb: Disk size in GB.<br/>- disk\_encryption\_set\_id: Disk Encryption Set ID. | <pre>object({<br/>    caching                = optional(string, "ReadWrite")<br/>    storage_account_type   = optional(string, "Premium_LRS")<br/>    disk_size_gb           = optional(number, null)<br/>    disk_encryption_set_id = optional(string, null)<br/>  })</pre> | `{}` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | (Required) The OS type for the VMSS. Values: Linux, Windows. | `string` | n/a | yes |
| <a name="input_overprovision"></a> [overprovision](#input\_overprovision) | (Optional) Enable overprovisioning. Default: false. | `bool` | `false` | no |
| <a name="input_platform_fault_domain_count"></a> [platform\_fault\_domain\_count](#input\_platform\_fault\_domain\_count) | (Optional) The number of fault domains. Default: null (Azure manages). | `number` | `null` | no |
| <a name="input_proximity_placement_group_id"></a> [proximity\_placement\_group\_id](#input\_proximity\_placement\_group\_id) | (Optional) The ID of the Proximity Placement Group. DEPENDENCY: PPG must exist. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_scale_in"></a> [scale\_in](#input\_scale\_in) | (Optional) Scale-in policy configuration.<br/>- rule: Scale-in rule. Values: Default, NewestVM, OldestVM. Default: Default.<br/>- force\_deletion\_enabled: Force delete VMs on scale-in. Default: false. | <pre>object({<br/>    rule                   = optional(string, "Default")<br/>    force_deletion_enabled = optional(bool, false)<br/>  })</pre> | `{}` | no |
| <a name="input_secure_boot_enabled"></a> [secure\_boot\_enabled](#input\_secure\_boot\_enabled) | (Optional) Enable Secure Boot. Default: false. | `bool` | `false` | no |
| <a name="input_single_placement_group"></a> [single\_placement\_group](#input\_single\_placement\_group) | (Optional) Use single placement group (max 100 VMs). Default: false. | `bool` | `false` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | (Required) The SKU size for the instances (e.g., Standard\_D2s\_v5). | `string` | n/a | yes |
| <a name="input_source_image_id"></a> [source\_image\_id](#input\_source\_image\_id) | (Optional) The ID of a custom image. DEPENDENCY: Image must exist. | `string` | `null` | no |
| <a name="input_source_image_reference"></a> [source\_image\_reference](#input\_source\_image\_reference) | (Optional) Source image reference from Marketplace. | <pre>object({<br/>    publisher = string<br/>    offer     = string<br/>    sku       = string<br/>    version   = optional(string, "latest")<br/>  })</pre> | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Required) The Subnet ID for the instances. DEPENDENCY: Subnet must exist. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_upgrade_mode"></a> [upgrade\_mode](#input\_upgrade\_mode) | (Optional) Upgrade mode. Values: Automatic, Manual, Rolling. Default: Manual. | `string` | `"Manual"` | no |
| <a name="input_vtpm_enabled"></a> [vtpm\_enabled](#input\_vtpm\_enabled) | (Optional) Enable vTPM. Default: false. | `bool` | `false` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for the naming convention. | `string` | `"app"` | no |
| <a name="input_zone_balance"></a> [zone\_balance](#input\_zone\_balance) | (Optional) Balance instances across zones. Default: true. | `bool` | `true` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | (Optional) List of Availability Zones for the VMSS. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | The admin password (if generated). |
| <a name="output_admin_username"></a> [admin\_username](#output\_admin\_username) | The admin username. |
| <a name="output_autoscale_setting_id"></a> [autoscale\_setting\_id](#output\_autoscale\_setting\_id) | The ID of the Autoscale Setting. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Virtual Machine Scale Set. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity block of the VMSS. |
| <a name="output_instances"></a> [instances](#output\_instances) | The number of instances. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Virtual Machine Scale Set. |
| <a name="output_os_type"></a> [os\_type](#output\_os\_type) | The OS type of the VMSS. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The Principal ID of the System Assigned Managed Identity. |
| <a name="output_sku"></a> [sku](#output\_sku) | The SKU of the VMSS. |
| <a name="output_unique_id"></a> [unique\_id](#output\_unique\_id) | The unique ID of the Virtual Machine Scale Set. |
<!-- END_TF_DOCS -->