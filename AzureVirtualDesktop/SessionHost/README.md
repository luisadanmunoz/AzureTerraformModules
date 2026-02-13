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
