#############################################################################
# GLOBAL TAGS
#############################################################################
variable "tags" {
  description = "value to set the global tags"
  type        = map(string)
  default     = {}
}

#############################################################################
# RESOURCE GROUPS
#############################################################################
variable "resources_groups" {
  description = "value to set the resources groups"
  type = map(object({
    resource_group_name = string
    location            = string
    tags                = optional(map(string))
  }))
  default = {}
}

#############################################################################
# VIRTUAL DESKTOP WORKSPACES
#############################################################################
variable "virtual_desktop_workspaces" {
  description = "value to set the virtual desktop workspaces"
  type = map(object({
    virtual_desktop_workspace_name = string
    resource_group_name            = optional(string)
    location                       = string
    friendly_name                  = optional(string)
    description                    = optional(string)
    public_network_access_enabled  = optional(bool)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# VIRTUAL DESKTOP HOST POOLS
#############################################################################
variable "virtual_desktop_host_pools" {
  description = "value to set the virtual desktop host pools"
  type = map(object({
    virtual_desktop_host_pool_name   = string
    resource_group_name              = optional(string)
    location                         = string
    type                             = string
    load_balancer_type               = string
    friendly_name                    = optional(string)
    description                      = optional(string)
    validate_environment             = optional(bool)
    start_vm_on_connect              = optional(bool)
    custom_rdp_properties            = optional(string)
    personal_desktop_assignment_type = optional(string)
    public_network_access            = optional(string)
    maximum_sessions_allowed         = optional(number)
    preferred_app_group_type         = optional(string)
    vm_template                      = optional(string)
    scheduled_agent_updates = optional(object({
      enabled                   = optional(bool)
      timezone                  = optional(string)
      use_session_host_timezone = optional(bool)
      schedule = optional(list(object({
        day_of_week = string
        hour_of_day = number
      })))
    }))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# VIRTUAL DESKTOP HOST POOL REGISTRATION INFOS
#############################################################################
variable "virtual_desktop_host_pool_registration_infos" {
  description = "value to set the virtual desktop host pool registration infos"
  type = map(object({
    virtual_desktop_host_pool_name = optional(string)
    hostpool_id                    = optional(string)
    expiration_date                = string
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# VIRTUAL DESKTOP APPLICATION GROUPS
#############################################################################
variable "virtual_desktop_application_groups" {
  description = "value to set the virtual desktop application groups"
  type = map(object({
    virtual_desktop_application_group_name = string
    resource_group_name                    = optional(string)
    location                               = string
    type                                   = string
    virtual_desktop_host_pool_name         = optional(string)
    host_pool_id                           = optional(string)
    friendly_name                          = optional(string)
    default_desktop_display_name           = optional(string)
    description                            = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# VIRTUAL DESKTOP APPLICATIONS
#############################################################################
variable "virtual_desktop_applications" {
  description = "value to set the virtual desktop applications"
  type = map(object({
    virtual_desktop_application_name       = string
    virtual_desktop_application_group_name = optional(string)
    application_group_id                   = optional(string)
    friendly_name                          = optional(string)
    description                            = optional(string)
    path                                   = string
    command_line_argument_policy           = string
    command_line_arguments                 = optional(string)
    show_in_portal                         = optional(bool)
    icon_path                              = optional(string)
    icon_index                             = optional(number)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# VIRTUAL DESKTOP WORKSPACE APPLICATION GROUP ASSOCIATIONS
#############################################################################
variable "virtual_desktop_workspace_application_group_associations" {
  description = "value to set the virtual desktop workspace application group associations"
  type = map(object({
    virtual_desktop_workspace_name         = optional(string)
    workspace_id                           = optional(string)
    virtual_desktop_application_group_name = optional(string)
    application_group_id                   = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# VIRTUAL DESKTOP SCALING PLANS
#############################################################################
variable "virtual_desktop_scaling_plans" {
  description = "value to set the virtual desktop scaling plans"
  type = map(object({
    virtual_desktop_scaling_plan_name = string
    resource_group_name               = optional(string)
    location                          = string
    time_zone                         = string
    friendly_name                     = optional(string)
    description                       = optional(string)
    exclusion_tag                     = optional(string)
    host_pool = optional(list(object({
      virtual_desktop_host_pool_name = optional(string)
      hostpool_id                    = optional(string)
      scaling_plan_enabled           = bool
    })))
    schedule = list(object({
      name                                 = string
      days_of_week                         = list(string)
      ramp_up_start_time                   = string
      ramp_up_load_balancing_algorithm     = string
      ramp_up_minimum_hosts_percent        = optional(number)
      ramp_up_capacity_threshold_percent   = optional(number)
      peak_start_time                      = string
      peak_load_balancing_algorithm        = string
      ramp_down_start_time                 = string
      ramp_down_load_balancing_algorithm   = string
      ramp_down_minimum_hosts_percent      = number
      ramp_down_force_logoff_users         = bool
      ramp_down_wait_time_minutes          = number
      ramp_down_notification_message       = string
      ramp_down_capacity_threshold_percent = number
      ramp_down_stop_hosts_when            = string
      off_peak_start_time                  = string
      off_peak_load_balancing_algorithm    = string
    }))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# VIRTUAL DESKTOP SCALING PLAN HOST POOL ASSOCIATIONS
#############################################################################
variable "virtual_desktop_scaling_plan_host_pool_associations" {
  description = "value to set the virtual desktop scaling plan host pool associations"
  type = map(object({
    virtual_desktop_scaling_plan_name = optional(string)
    scaling_plan_id                   = optional(string)
    virtual_desktop_host_pool_name    = optional(string)
    host_pool_id                      = optional(string)
    enabled                           = bool
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}
