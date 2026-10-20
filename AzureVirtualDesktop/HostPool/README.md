# Azure Virtual Desktop Host Pool Module

Terraform module for creating and managing Azure Virtual Desktop Host Pools.

## Description

This module creates an AVD Host Pool with support for:

- **Pool Types**: Personal (dedicated) or Pooled (shared) desktops
- **Load Balancing**: BreadthFirst, DepthFirst, or Persistent
- **Start VM on Connect**: Automatic VM startup when users connect
- **Custom RDP Properties**: Configure clipboard, devices, monitors, etc.
- **Scheduled Agent Updates**: Control when AVD agents update
- **Registration Tokens**: Generate tokens for session host enrollment

## Usage

### Basic Pooled Host Pool

```hcl
module "hostpool" {
  source = "./AzureVirtualDesktop/HostPool"

  resource_group_name = "rg-avd-prod-001"
  location            = "westeurope"
  name                = "vdpool-general-prod-001"

  type                     = "Pooled"
  load_balancer_type       = "BreadthFirst"
  maximum_sessions_allowed = 10

  friendly_name = "General Desktop Pool"
  description   = "Shared desktop pool for general users"

  start_vm_on_connect = true

  tags = {
    Environment = "Production"
  }
}
```

### Personal Host Pool

```hcl
module "hostpool_personal" {
  source = "./AzureVirtualDesktop/HostPool"

  resource_group_name = "rg-avd-prod-001"
  location            = "westeurope"
  name                = "vdpool-developers-prod-001"

  type                             = "Personal"
  load_balancer_type               = "Persistent"
  personal_desktop_assignment_type = "Automatic"

  friendly_name       = "Developer Desktops"
  start_vm_on_connect = true

  # Generate registration token
  registration_expiration_date = timeadd(timestamp(), "24h")

  tags = {
    Environment = "Production"
    Team        = "Development"
  }
}
```

### With Custom RDP Properties

```hcl
module "hostpool_secure" {
  source = "./AzureVirtualDesktop/HostPool"

  resource_group_name = "rg-avd-prod-001"
  location            = "westeurope"

  type                     = "Pooled"
  load_balancer_type       = "DepthFirst"
  maximum_sessions_allowed = 8

  # Secure RDP settings
  custom_rdp_properties = join(";", [
    "audiocapturemode:i:0",          # Disable audio capture
    "camerastoredirect:s:",          # Disable camera redirect
    "drivestoredirect:s:",           # Disable drive redirect
    "redirectclipboard:i:0",         # Disable clipboard
    "redirectprinters:i:0",          # Disable printer redirect
    "redirectsmartcards:i:1",        # Enable smart card redirect
    "use multimon:i:1",              # Enable multi-monitor
    "enablecredsspsupport:i:1",      # Enable CredSSP
  ])

  tags = {
    Environment  = "Production"
    SecurityTier = "High"
  }
}
```

### With Scheduled Agent Updates

```hcl
module "hostpool_scheduled" {
  source = "./AzureVirtualDesktop/HostPool"

  resource_group_name = "rg-avd-prod-001"
  location            = "westeurope"

  type                     = "Pooled"
  load_balancer_type       = "BreadthFirst"
  maximum_sessions_allowed = 10

  scheduled_agent_updates = {
    enabled  = true
    timezone = "Romance Standard Time"
    schedule = [
      {
        day_of_week = "Saturday"
        hour_of_day = 2
      },
      {
        day_of_week = "Sunday"
        hour_of_day = 2
      }
    ]
  }

  tags = {
    Environment = "Production"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether to create the resource | `bool` | `true` | no |
| resource_group_name | The name of the Resource Group | `string` | n/a | yes |
| location | The Azure Region | `string` | n/a | yes |
| name | The name of the Host Pool | `string` | `null` | no |
| type | Pool type: Personal or Pooled | `string` | n/a | yes |
| load_balancer_type | Load balancing: BreadthFirst, DepthFirst, Persistent | `string` | n/a | yes |
| maximum_sessions_allowed | Max sessions per host (Pooled only) | `number` | `null` | no |
| personal_desktop_assignment_type | Assignment type (Personal only) | `string` | `null` | no |
| start_vm_on_connect | Enable Start VM on Connect | `bool` | `false` | no |
| custom_rdp_properties | Custom RDP properties string | `string` | `null` | no |
| registration_expiration_date | Token expiration in RFC3339 | `string` | `null` | no |
| scheduled_agent_updates | Agent update schedule config | `object` | `null` | no |
| tags | Tags to assign | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Host Pool |
| name | The name of the Host Pool |
| type | The type of the Host Pool |
| load_balancer_type | The load balancer type |
| registration_token | The registration token (sensitive) |
| registration_expiration_date | Token expiration date |

## Dependencies

- Resource Group must exist

## Related Modules

- [ApplicationGroup](../ApplicationGroup) - Create application groups for this host pool
- [Workspace](../Workspace) - Create workspaces to publish applications
- [ScalingPlan](../ScalingPlan) - Configure autoscaling for this host pool
