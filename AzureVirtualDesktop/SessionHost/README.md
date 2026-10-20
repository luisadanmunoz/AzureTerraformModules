# Azure Virtual Desktop Session Host Module

Terraform module for creating and managing Azure Virtual Desktop Session Hosts.

## Description

This module creates AVD Session Host VMs with support for:

- **Multiple VMs**: Deploy 1-100 session hosts at once
- **Windows 10/11 Multi-session**: Azure Marketplace or custom images
- **Azure AD Join**: Native Azure AD integration with optional Intune
- **Active Directory Join**: Traditional domain join
- **Trusted Launch**: Secure Boot and vTPM enabled by default
- **Availability**: Availability Sets or Zone distribution
- **AVD Agent**: Automatic installation and host pool registration

## Usage

### Basic Azure AD Joined Session Hosts

```hcl
module "session_hosts" {
  source = "./AzureVirtualDesktop/SessionHost"

  resource_group_name = "rg-avd-prod-001"
  location            = "westeurope"

  instance_count = 3
  vm_size        = "Standard_D4s_v5"
  subnet_id      = module.subnet.id

  # Host Pool registration
  hostpool_id        = module.hostpool.id
  registration_token = module.hostpool.registration_token

  # Azure AD Join
  domain_join_type = "AzureAD"
  aad_join = {
    intune_enrollment = true
  }

  tags = {
    Environment = "Production"
  }
}
```

### Active Directory Domain Joined

```hcl
module "session_hosts" {
  source = "./AzureVirtualDesktop/SessionHost"

  resource_group_name = "rg-avd-prod-001"
  location            = "westeurope"

  instance_count = 5
  vm_size        = "Standard_D8s_v5"
  subnet_id      = module.subnet.id

  hostpool_id        = module.hostpool.id
  registration_token = module.hostpool.registration_token

  # AD Domain Join
  domain_join_type = "ActiveDirectory"
  ad_domain_join = {
    domain_name     = "corp.contoso.com"
    ou_path         = "OU=AVD,OU=Computers,DC=corp,DC=contoso,DC=com"
    domain_username = "svc_avd_join"
    domain_password = var.domain_join_password
  }

  tags = {
    Environment = "Production"
  }
}
```

### With Custom Image from Azure Compute Gallery

```hcl
module "session_hosts" {
  source = "./AzureVirtualDesktop/SessionHost"

  resource_group_name = "rg-avd-prod-001"
  location            = "westeurope"

  instance_count = 4
  vm_size        = "Standard_D4s_v5"
  subnet_id      = module.subnet.id

  # Custom image
  source_image_id = "/subscriptions/xxx/resourceGroups/rg-images/providers/Microsoft.Compute/galleries/gallery/images/win11-avd/versions/1.0.0"

  hostpool_id        = module.hostpool.id
  registration_token = module.hostpool.registration_token

  domain_join_type = "AzureAD"

  tags = {
    Environment = "Production"
    ImageType   = "Custom"
  }
}
```

### High Availability with Zone Distribution

```hcl
module "session_hosts" {
  source = "./AzureVirtualDesktop/SessionHost"

  resource_group_name = "rg-avd-prod-001"
  location            = "westeurope"

  instance_count = 6
  vm_size        = "Standard_D4s_v5"
  subnet_id      = module.subnet.id

  # Distribute across zones 1, 2, 3
  zones_distribution = true

  # Premium storage for zones
  os_disk = {
    storage_account_type = "Premium_LRS"
    disk_size_gb         = 256
  }

  hostpool_id        = module.hostpool.id
  registration_token = module.hostpool.registration_token

  domain_join_type = "AzureAD"

  tags = {
    Environment = "Production"
    HA          = "ZoneRedundant"
  }
}
```

### With Encryption and Security Features

```hcl
module "session_hosts_secure" {
  source = "./AzureVirtualDesktop/SessionHost"

  resource_group_name = "rg-avd-prod-001"
  location            = "westeurope"

  instance_count = 3
  vm_size        = "Standard_D4s_v5"
  subnet_id      = module.subnet.id

  # Security features
  secure_boot_enabled        = true
  vtpm_enabled               = true
  encryption_at_host_enabled = true

  os_disk = {
    storage_account_type   = "Premium_LRS"
    disk_encryption_set_id = module.disk_encryption_set.id
  }

  hostpool_id        = module.hostpool.id
  registration_token = module.hostpool.registration_token

  domain_join_type = "AzureAD"
  aad_join = {
    intune_enrollment = true # For compliance policies
  }

  tags = {
    Environment  = "Production"
    SecurityTier = "High"
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
| create | Controls whether to create resources | `bool` | `true` | no |
| resource_group_name | The name of the Resource Group | `string` | n/a | yes |
| location | The Azure Region | `string` | n/a | yes |
| instance_count | Number of Session Host VMs | `number` | `1` | no |
| vm_size | VM SKU size | `string` | `"Standard_D4s_v5"` | no |
| admin_username | Admin username | `string` | `"avdadmin"` | no |
| admin_password | Admin password (generated if null) | `string` | `null` | no |
| subnet_id | Subnet ID for VMs | `string` | n/a | yes |
| hostpool_id | Host Pool ID | `string` | n/a | yes |
| registration_token | Host Pool registration token | `string` | n/a | yes |
| domain_join_type | Join type: AzureAD, ActiveDirectory, None | `string` | `"AzureAD"` | no |
| source_image_id | Custom image ID | `string` | `null` | no |
| source_image_reference | Marketplace image reference | `object` | Win11 AVD | no |
| os_disk | OS disk configuration | `object` | Premium 128GB | no |
| zones_distribution | Distribute VMs across zones | `bool` | `false` | no |
| tags | Tags to assign | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| vm_ids | Session Host VM IDs |
| vm_names | Session Host VM names |
| vm_computer_names | Computer names |
| private_ip_addresses | Private IP addresses |
| identity_principal_ids | System Assigned Identity Principal IDs |
| admin_password | Admin password (sensitive) |
| instance_count | Number of VMs created |

## Dependencies

- Resource Group must exist
- Subnet must exist (DEPENDENCY: Networking modules)
- Host Pool must exist (DEPENDENCY: HostPool module)
- Registration token from Host Pool

## Complete AVD Deployment Example

```hcl
# 1. Host Pool
module "hostpool" {
  source = "./AzureVirtualDesktop/HostPool"

  resource_group_name          = azurerm_resource_group.avd.name
  location                     = azurerm_resource_group.avd.location
  type                         = "Pooled"
  load_balancer_type           = "BreadthFirst"
  maximum_sessions_allowed     = 10
  registration_expiration_date = timeadd(timestamp(), "24h")
}

# 2. Application Group
module "app_group" {
  source = "./AzureVirtualDesktop/ApplicationGroup"

  resource_group_name = azurerm_resource_group.avd.name
  location            = azurerm_resource_group.avd.location
  host_pool_id        = module.hostpool.id
  type                = "Desktop"
}

# 3. Workspace
module "workspace" {
  source = "./AzureVirtualDesktop/Workspace"

  resource_group_name   = azurerm_resource_group.avd.name
  location              = azurerm_resource_group.avd.location
  application_group_ids = [module.app_group.id]
}

# 4. Session Hosts
module "session_hosts" {
  source = "./AzureVirtualDesktop/SessionHost"

  resource_group_name = azurerm_resource_group.avd.name
  location            = azurerm_resource_group.avd.location

  instance_count     = 3
  subnet_id          = module.subnet.id
  hostpool_id        = module.hostpool.id
  registration_token = module.hostpool.registration_token
  domain_join_type   = "AzureAD"
}

# 5. Scaling Plan
module "scaling_plan" {
  source = "./AzureVirtualDesktop/ScalingPlan"

  resource_group_name = azurerm_resource_group.avd.name
  location            = azurerm_resource_group.avd.location

  host_pool_associations = [{
    hostpool_id = module.hostpool.id
  }]

  schedules = [...]
}

# 6. User Access (RBAC)
module "user_access" {
  source = "./Gobernanza/RoleAssignment"

  assignments = [{
    scope                = module.app_group.id
    role_definition_name = "Desktop Virtualization User"
    principal_id         = "user-or-group-object-id"
  }]
}
```

## Notes

- VMs need network connectivity to Azure AD and AVD service endpoints
- For Azure AD join, the VM identity needs proper permissions
- Registration tokens expire; regenerate before deploying new hosts
- Windows license (AHUB) requires eligible licenses

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
| [azurerm_network_interface.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_virtual_machine_extension.aad_join](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.ad_domain_join](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.avd_agent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_windows_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [random_password.admin](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_aad_join"></a> [aad\_join](#input\_aad\_join) | (Optional) Azure AD Join configuration. Required if domain\_join\_type is AzureAD.<br/>- intune\_enrollment: Enable Intune enrollment. Default: false. | <pre>object({<br/>    intune_enrollment = optional(bool, false)<br/>  })</pre> | `{}` | no |
| <a name="input_ad_domain_join"></a> [ad\_domain\_join](#input\_ad\_domain\_join) | (Optional) Active Directory domain join configuration. Required if domain\_join\_type is ActiveDirectory.<br/>- domain\_name: FQDN of the AD domain.<br/>- ou\_path: OU path for computer objects.<br/>- domain\_username: Domain admin username.<br/>- domain\_password: Domain admin password. | <pre>object({<br/>    domain_name     = string<br/>    ou_path         = optional(string, null)<br/>    domain_username = string<br/>    domain_password = string<br/>  })</pre> | `null` | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | (Optional) The admin password for the VMs. If not provided, a random password will be generated. | `string` | `null` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | (Required) The admin username for the VMs. | `string` | `"avdadmin"` | no |
| <a name="input_availability_set_id"></a> [availability\_set\_id](#input\_availability\_set\_id) | (Optional) The ID of an Availability Set. DEPENDENCY: Availability Set must exist. | `string` | `null` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | (Optional) The Availability Zone for the VMs. Values: 1, 2, 3, or null for no zone. | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Session Hosts. | `bool` | `true` | no |
| <a name="input_domain_join_type"></a> [domain\_join\_type](#input\_domain\_join\_type) | (Optional) Domain join type. Values: AzureAD, ActiveDirectory, None. Default: AzureAD. | `string` | `"AzureAD"` | no |
| <a name="input_enable_accelerated_networking"></a> [enable\_accelerated\_networking](#input\_enable\_accelerated\_networking) | (Optional) Enable accelerated networking. Default: true. | `bool` | `true` | no |
| <a name="input_encryption_at_host_enabled"></a> [encryption\_at\_host\_enabled](#input\_encryption\_at\_host\_enabled) | (Optional) Enable encryption at host. Default: false. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_hostpool_id"></a> [hostpool\_id](#input\_hostpool\_id) | (Required) The ID of the AVD Host Pool. DEPENDENCY: Host Pool must exist. | `string` | n/a | yes |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | (Optional) List of User Assigned Identity IDs. DEPENDENCY: Identities must exist. | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | (Optional) Identity type. Values: SystemAssigned, UserAssigned, SystemAssigned, UserAssigned. Default: SystemAssigned. | `string` | `"SystemAssigned"` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | (Required) Number of Session Host VMs to create. | `number` | `1` | no |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | (Optional) License type for Windows. Values: Windows\_Client, Windows\_Server, None. | `string` | `"Windows_Client"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Session Hosts should exist. | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for the VM names. Default: 'vdsh'. | `string` | `"vdsh"` | no |
| <a name="input_os_disk"></a> [os\_disk](#input\_os\_disk) | (Optional) OS disk configuration.<br/>- caching: Disk caching type. Default: ReadWrite.<br/>- storage\_account\_type: Disk type. Default: Premium\_LRS.<br/>- disk\_size\_gb: Disk size in GB. Default: 128.<br/>- disk\_encryption\_set\_id: ID of the disk encryption set. | <pre>object({<br/>    caching                = optional(string, "ReadWrite")<br/>    storage_account_type   = optional(string, "Premium_LRS")<br/>    disk_size_gb           = optional(number, 128)<br/>    disk_encryption_set_id = optional(string, null)<br/>  })</pre> | `{}` | no |
| <a name="input_private_ip_address_allocation"></a> [private\_ip\_address\_allocation](#input\_private\_ip\_address\_allocation) | (Optional) IP allocation method. Values: Dynamic, Static. Default: Dynamic. | `string` | `"Dynamic"` | no |
| <a name="input_registration_token"></a> [registration\_token](#input\_registration\_token) | (Required) The registration token from the Host Pool. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_secure_boot_enabled"></a> [secure\_boot\_enabled](#input\_secure\_boot\_enabled) | (Optional) Enable Secure Boot for Trusted Launch. Default: true. | `bool` | `true` | no |
| <a name="input_source_image_id"></a> [source\_image\_id](#input\_source\_image\_id) | (Optional) The ID of the custom image or Azure Compute Gallery image. DEPENDENCY: Image must exist. | `string` | `null` | no |
| <a name="input_source_image_reference"></a> [source\_image\_reference](#input\_source\_image\_reference) | (Optional) Source image reference from Azure Marketplace. Used if source\_image\_id is not provided.<br/>- publisher: Image publisher (e.g., MicrosoftWindowsDesktop)<br/>- offer: Image offer (e.g., windows-11)<br/>- sku: Image SKU (e.g., win11-23h2-avd)<br/>- version: Image version (e.g., latest) | <pre>object({<br/>    publisher = string<br/>    offer     = string<br/>    sku       = string<br/>    version   = string<br/>  })</pre> | <pre>{<br/>  "offer": "windows-11",<br/>  "publisher": "MicrosoftWindowsDesktop",<br/>  "sku": "win11-23h2-avd",<br/>  "version": "latest"<br/>}</pre> | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Required) The ID of the Subnet for the VMs. DEPENDENCY: Subnet must exist. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resources. | `map(string)` | `{}` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | (Optional) The timezone for the VMs. | `string` | `"UTC"` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | (Required) The SKU for the Session Host VMs. | `string` | `"Standard_D4s_v5"` | no |
| <a name="input_vtpm_enabled"></a> [vtpm\_enabled](#input\_vtpm\_enabled) | (Optional) Enable vTPM for Trusted Launch. Default: true. | `bool` | `true` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for the naming convention. | `string` | `"avd"` | no |
| <a name="input_zones_distribution"></a> [zones\_distribution](#input\_zones\_distribution) | (Optional) Distribute VMs across zones. If true, ignores availability\_zone. | `bool` | `false` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | The admin password for the VMs (generated if not provided). |
| <a name="output_admin_username"></a> [admin\_username](#output\_admin\_username) | The admin username for the VMs. |
| <a name="output_identity_principal_ids"></a> [identity\_principal\_ids](#output\_identity\_principal\_ids) | The Principal IDs of the System Assigned Identities. |
| <a name="output_instance_count"></a> [instance\_count](#output\_instance\_count) | The number of Session Host VMs created. |
| <a name="output_network_interface_ids"></a> [network\_interface\_ids](#output\_network\_interface\_ids) | The IDs of the Network Interfaces. |
| <a name="output_private_ip_addresses"></a> [private\_ip\_addresses](#output\_private\_ip\_addresses) | The private IP addresses of the Session Host VMs. |
| <a name="output_vm_computer_names"></a> [vm\_computer\_names](#output\_vm\_computer\_names) | The computer names of the Session Host VMs. |
| <a name="output_vm_ids"></a> [vm\_ids](#output\_vm\_ids) | The IDs of the Session Host VMs. |
| <a name="output_vm_names"></a> [vm\_names](#output\_vm\_names) | The names of the Session Host VMs. |
<!-- END_TF_DOCS -->