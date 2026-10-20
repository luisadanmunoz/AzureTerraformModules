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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0, < 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_virtual_desktop_host_pool.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_host_pool) | resource |
| [azurerm_virtual_desktop_host_pool_registration_info.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_host_pool_registration_info) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the AVD Host Pool. | `bool` | `true` | no |
| <a name="input_custom_rdp_properties"></a> [custom\_rdp\_properties](#input\_custom\_rdp\_properties) | (Optional) Custom RDP properties string. | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description for the Host Pool. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_friendly_name"></a> [friendly\_name](#input\_friendly\_name) | (Optional) A friendly name for the Host Pool. | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number for the naming convention. | `string` | `"001"` | no |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | (Required) The load balancer type. Values: BreadthFirst, DepthFirst, Persistent. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Host Pool should exist. | `string` | n/a | yes |
| <a name="input_maximum_sessions_allowed"></a> [maximum\_sessions\_allowed](#input\_maximum\_sessions\_allowed) | (Optional) Maximum concurrent sessions per host. Required for Pooled pools. | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the Host Pool. If not provided, a name will be generated. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for the generated name. Default: 'vdpool'. | `string` | `"vdpool"` | no |
| <a name="input_personal_desktop_assignment_type"></a> [personal\_desktop\_assignment\_type](#input\_personal\_desktop\_assignment\_type) | (Optional) Personal desktop assignment type. Values: Automatic, Direct. Required for Personal pools. | `string` | `null` | no |
| <a name="input_preferred_app_group_type"></a> [preferred\_app\_group\_type](#input\_preferred\_app\_group\_type) | (Optional) Preferred Application Group type. Values: Desktop, RailApplications. Default: Desktop. | `string` | `"Desktop"` | no |
| <a name="input_registration_expiration_date"></a> [registration\_expiration\_date](#input\_registration\_expiration\_date) | (Optional) The expiration date for the registration token in RFC3339 format. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_scheduled_agent_updates"></a> [scheduled\_agent\_updates](#input\_scheduled\_agent\_updates) | (Optional) Scheduled agent updates configuration.<br/>- enabled: Whether scheduled updates are enabled.<br/>- timezone: Timezone for the schedule.<br/>- use\_session\_host\_timezone: Use session host's timezone.<br/>- schedule: List of schedules with day\_of\_week and hour\_of\_day. | <pre>object({<br/>    enabled                   = optional(bool, true)<br/>    timezone                  = optional(string, "UTC")<br/>    use_session_host_timezone = optional(bool, false)<br/>    schedule = optional(list(object({<br/>      day_of_week = string<br/>      hour_of_day = number<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_start_vm_on_connect"></a> [start\_vm\_on\_connect](#input\_start\_vm\_on\_connect) | (Optional) Enables Start VM on Connect. Default: false. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | (Required) The type of the Host Pool. Values: Personal, Pooled. | `string` | n/a | yes |
| <a name="input_validate_environment"></a> [validate\_environment](#input\_validate\_environment) | (Optional) Whether to validate the environment. Default: false. | `bool` | `false` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for the naming convention. | `string` | `"avd"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the AVD Host Pool. |
| <a name="output_load_balancer_type"></a> [load\_balancer\_type](#output\_load\_balancer\_type) | The load balancer type of the Host Pool. |
| <a name="output_name"></a> [name](#output\_name) | The name of the AVD Host Pool. |
| <a name="output_registration_expiration_date"></a> [registration\_expiration\_date](#output\_registration\_expiration\_date) | The expiration date of the registration token. |
| <a name="output_registration_token"></a> [registration\_token](#output\_registration\_token) | The registration token for the Host Pool. |
| <a name="output_type"></a> [type](#output\_type) | The type of the AVD Host Pool (Personal or Pooled). |
<!-- END_TF_DOCS -->