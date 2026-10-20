# Azure Virtual Desktop Scaling Plan Module

Terraform module for creating and managing Azure Virtual Desktop Scaling Plans.

## Description

This module creates an AVD Scaling Plan for automatic scaling of session hosts with support for:

- **Time-Based Scaling**: Different settings for ramp-up, peak, ramp-down, and off-peak
- **Load Balancing Algorithms**: BreadthFirst or DepthFirst per phase
- **User Notifications**: Warn users before forced logoff
- **Exclusion Tags**: Exclude specific VMs from scaling
- **Multiple Schedules**: Different schedules for weekdays vs weekends
- **Host Pool Associations**: Apply scaling to multiple host pools

## Usage

### Basic Scaling Plan

```hcl
module "scaling_plan" {
  source = "./AzureVirtualDesktop/ScalingPlan"

  resource_group_name = "rg-avd-prod-001"
  location            = "westeurope"
  name                = "vdscaling-general-prod-001"

  friendly_name = "Business Hours Scaling"
  time_zone     = "Romance Standard Time"

  host_pool_associations = [
    {
      hostpool_id = module.hostpool.id
      enabled     = true
    }
  ]

  schedules = [
    {
      name         = "Weekday"
      days_of_week = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]

      # 7 AM - Ramp up
      ramp_up_start_time                 = "07:00"
      ramp_up_load_balancing_algorithm   = "BreadthFirst"
      ramp_up_minimum_hosts_percent      = 25
      ramp_up_capacity_threshold_percent = 60

      # 9 AM - Peak hours
      peak_start_time               = "09:00"
      peak_load_balancing_algorithm = "BreadthFirst"

      # 5 PM - Ramp down
      ramp_down_start_time                 = "17:00"
      ramp_down_load_balancing_algorithm   = "DepthFirst"
      ramp_down_minimum_hosts_percent      = 10
      ramp_down_capacity_threshold_percent = 90
      ramp_down_force_logoff_users         = false
      ramp_down_wait_time_minutes          = 30
      ramp_down_notification_message       = "Please save your work. The session will end in 30 minutes."
      ramp_down_stop_hosts_when            = "ZeroSessions"

      # 8 PM - Off peak
      off_peak_start_time               = "20:00"
      off_peak_load_balancing_algorithm = "DepthFirst"
    }
  ]

  tags = {
    Environment = "Production"
  }
}
```

### With Weekend Schedule

```hcl
module "scaling_plan" {
  source = "./AzureVirtualDesktop/ScalingPlan"

  resource_group_name = "rg-avd-prod-001"
  location            = "westeurope"

  workload    = "corporate"
  environment = "prod"

  time_zone = "UTC"

  host_pool_associations = [
    {
      hostpool_id = module.hostpool.id
      enabled     = true
    }
  ]

  schedules = [
    {
      name         = "Weekday"
      days_of_week = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]

      ramp_up_start_time                 = "06:00"
      ramp_up_minimum_hosts_percent      = 30
      ramp_up_capacity_threshold_percent = 50

      peak_start_time = "08:00"

      ramp_down_start_time                 = "18:00"
      ramp_down_minimum_hosts_percent      = 10
      ramp_down_capacity_threshold_percent = 90
      ramp_down_force_logoff_users         = true
      ramp_down_wait_time_minutes          = 15
      ramp_down_stop_hosts_when            = "ZeroActiveSessions"

      off_peak_start_time = "22:00"
    },
    {
      name         = "Weekend"
      days_of_week = ["Saturday", "Sunday"]

      # Minimal hosts on weekends
      ramp_up_start_time            = "08:00"
      ramp_up_minimum_hosts_percent = 10

      peak_start_time = "10:00"

      ramp_down_start_time         = "16:00"
      ramp_down_force_logoff_users = true
      ramp_down_wait_time_minutes  = 10
      ramp_down_stop_hosts_when    = "ZeroSessions"

      off_peak_start_time = "18:00"
    }
  ]

  tags = {
    Environment = "Production"
  }
}
```

### Aggressive Cost Optimization

```hcl
module "scaling_plan_aggressive" {
  source = "./AzureVirtualDesktop/ScalingPlan"

  resource_group_name = "rg-avd-prod-001"
  location            = "westeurope"
  name                = "vdscaling-aggressive-prod-001"

  friendly_name = "Aggressive Cost Saving"
  time_zone     = "UTC"
  exclusion_tag = "avd-exclude-scaling" # VMs with this tag won't be scaled

  host_pool_associations = [
    {
      hostpool_id = module.hostpool.id
      enabled     = true
    }
  ]

  schedules = [
    {
      name         = "AllDays"
      days_of_week = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

      # Very short ramp-up
      ramp_up_start_time                 = "07:30"
      ramp_up_load_balancing_algorithm   = "DepthFirst"
      ramp_up_minimum_hosts_percent      = 10
      ramp_up_capacity_threshold_percent = 80

      # Short peak
      peak_start_time               = "08:00"
      peak_load_balancing_algorithm = "DepthFirst"

      # Early aggressive ramp-down
      ramp_down_start_time                 = "16:00"
      ramp_down_load_balancing_algorithm   = "DepthFirst"
      ramp_down_minimum_hosts_percent      = 0
      ramp_down_capacity_threshold_percent = 95
      ramp_down_force_logoff_users         = true
      ramp_down_wait_time_minutes          = 5
      ramp_down_notification_message       = "System shutdown in 5 minutes. Please save immediately."
      ramp_down_stop_hosts_when            = "ZeroActiveSessions"

      # Off-peak: minimum hosts
      off_peak_start_time               = "18:00"
      off_peak_load_balancing_algorithm = "DepthFirst"
    }
  ]

  tags = {
    Environment = "Production"
    CostCenter  = "IT"
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
| name | The name of the Scaling Plan | `string` | `null` | no |
| time_zone | Timezone for schedules | `string` | `"UTC"` | no |
| exclusion_tag | Tag to exclude VMs from scaling | `string` | `null` | no |
| host_pool_associations | Host pools to apply scaling | `list(object)` | `[]` | no |
| schedules | Scaling schedules configuration | `list(object)` | `[]` | yes |
| tags | Tags to assign | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Scaling Plan |
| name | The name of the Scaling Plan |
| time_zone | The timezone of the Scaling Plan |
| schedule_names | Names of configured schedules |

## Dependencies

- Resource Group must exist
- Host Pool must exist (if associating)

## Related Modules

- [HostPool](../HostPool) - Create host pools for scaling

## Load Balancing Algorithms

- **BreadthFirst**: Distributes users across all available hosts (better user experience)
- **DepthFirst**: Fills hosts to capacity before using new ones (cost optimization)

## Scaling Phases

1. **Ramp-up**: Scale up hosts before peak hours
2. **Peak**: Maximum capacity during business hours
3. **Ramp-down**: Gradually reduce hosts, notify users
4. **Off-peak**: Minimum hosts outside business hours

## Notes

- The Scaling Plan requires the "Desktop Virtualization Power On Off Contributor" role on the subscription or resource group
- VMs with the exclusion tag will not be affected by scaling
- Force logoff should be used carefully to avoid data loss

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
| [azurerm_virtual_desktop_scaling_plan.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_scaling_plan) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the AVD Scaling Plan. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description for the Scaling Plan. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_exclusion_tag"></a> [exclusion\_tag](#input\_exclusion\_tag) | (Optional) Tag name to exclude VMs from scaling. | `string` | `null` | no |
| <a name="input_friendly_name"></a> [friendly\_name](#input\_friendly\_name) | (Optional) A friendly name for the Scaling Plan. | `string` | `null` | no |
| <a name="input_host_pool_associations"></a> [host\_pool\_associations](#input\_host\_pool\_associations) | (Optional) List of Host Pool associations.<br/>- hostpool\_id: The ID of the Host Pool. DEPENDENCY: Host Pool must exist.<br/>- enabled: Whether scaling is enabled for this host pool. | <pre>list(object({<br/>    hostpool_id = string<br/>    enabled     = optional(bool, true)<br/>  }))</pre> | `[]` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number for the naming convention. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Scaling Plan should exist. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the Scaling Plan. If not provided, a name will be generated. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for the generated name. Default: 'vdscaling'. | `string` | `"vdscaling"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_schedules"></a> [schedules](#input\_schedules) | (Required) List of scaling schedules.<br/>- name: Name of the schedule.<br/>- days\_of\_week: Days the schedule applies (Monday, Tuesday, etc.).<br/>- ramp\_up\_*: Ramp-up period settings.<br/>- peak\_*: Peak hours settings.<br/>- ramp\_down\_*: Ramp-down period settings.<br/>- off\_peak\_*: Off-peak hours settings. | <pre>list(object({<br/>    name         = string<br/>    days_of_week = list(string)<br/><br/>    # Ramp-up settings<br/>    ramp_up_start_time                 = string<br/>    ramp_up_load_balancing_algorithm   = optional(string, "BreadthFirst")<br/>    ramp_up_minimum_hosts_percent      = optional(number, 20)<br/>    ramp_up_capacity_threshold_percent = optional(number, 60)<br/><br/>    # Peak settings<br/>    peak_start_time                 = string<br/>    peak_load_balancing_algorithm   = optional(string, "BreadthFirst")<br/><br/>    # Ramp-down settings<br/>    ramp_down_start_time                    = string<br/>    ramp_down_load_balancing_algorithm      = optional(string, "DepthFirst")<br/>    ramp_down_minimum_hosts_percent         = optional(number, 10)<br/>    ramp_down_capacity_threshold_percent    = optional(number, 90)<br/>    ramp_down_force_logoff_users            = optional(bool, false)<br/>    ramp_down_wait_time_minutes             = optional(number, 30)<br/>    ramp_down_notification_message          = optional(string, "You will be logged off in 30 minutes. Please save your work.")<br/>    ramp_down_stop_hosts_when               = optional(string, "ZeroSessions")<br/><br/>    # Off-peak settings<br/>    off_peak_start_time                 = string<br/>    off_peak_load_balancing_algorithm   = optional(string, "DepthFirst")<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_time_zone"></a> [time\_zone](#input\_time\_zone) | (Required) The timezone for the Scaling Plan schedules. | `string` | `"UTC"` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for the naming convention. | `string` | `"avd"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the AVD Scaling Plan. |
| <a name="output_name"></a> [name](#output\_name) | The name of the AVD Scaling Plan. |
| <a name="output_schedule_names"></a> [schedule\_names](#output\_schedule\_names) | The names of the schedules in the Scaling Plan. |
| <a name="output_time_zone"></a> [time\_zone](#output\_time\_zone) | The timezone of the Scaling Plan. |
<!-- END_TF_DOCS -->