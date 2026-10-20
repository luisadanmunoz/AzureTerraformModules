#############################################################################
# GLOBAL TAGS
#############################################################################
variable "tags" {
  description = "value to set the global tags"
  type        = map(string)
  default     = {}
}

#############################################################################
# RESOURCES GROUPS
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
# TAGS DEFINITIONS
#############################################################################
variable "tags_definitions" {
  description = "value to set the tags definitions"
  type = map(object({
    workload_name       = string
    environment         = string
    owner               = string
    cost_center         = string
    data_classification = optional(string)
    criticality         = optional(string)
    managed_by          = optional(string)
    custom_tags         = optional(map(string))
  }))
  default = {}
}

#############################################################################
# MANAGEMENT GROUPS
#############################################################################
variable "management_groups" {
  description = "value to set the management groups"
  type = map(object({
    management_group_name        = string
    display_name                 = string
    parent_management_group_name = optional(string)
    parent_management_group_id   = optional(string)
    subscription_ids             = optional(list(string))
  }))
  default = {}
}

#############################################################################
# SUBSCRIPTIONS PLACEMENTS
#############################################################################
variable "subscription_placements" {
  description = "value to set the subscriptions placements"
  type = map(object({
    management_group_name = optional(string)
    management_group_id   = optional(string)
    subscription_id       = string
  }))
  default = {}
}

#############################################################################
# ROLE ASSIGNMENTS
#############################################################################
variable "role_assignments" {
  description = "value to set the role assignments"
  type = map(object({
    scope                            = optional(string)
    resource_group_name              = optional(string)
    management_group_name            = optional(string)
    principal_id                     = string
    role_definition_name             = optional(string)
    role_definition_id               = optional(string)
    principal_type                   = optional(string)
    description                      = optional(string)
    condition                        = optional(string)
    condition_version                = optional(string)
    skip_service_principal_aad_check = optional(bool)
  }))
  default = {}
}

#############################################################################
# RESOURCE LOCKS
#############################################################################
variable "resource_locks" {
  description = "value to set the resource locks"
  type = map(object({
    lock_name             = string
    scope                 = optional(string)
    resource_group_name   = optional(string)
    management_group_name = optional(string)
    lock_level            = string
    notes                 = optional(string)
  }))
  default = {}
}

#############################################################################
# DIAGNOSTIC SETTINGS
#############################################################################
variable "diagnostic_settings" {
  description = "value to set the diagnostic settings"
  type = map(object({
    diagnostic_settings_name       = string
    target_resource_id             = string
    log_analytics_workspace_id     = optional(string)
    log_analytics_destination_type = optional(string)
    storage_account_id             = optional(string)
    eventhub_authorization_rule_id = optional(string)
    eventhub_name                  = optional(string)
    log_categories                 = optional(list(string))
    metric_categories              = optional(list(string))
  }))
  default = {}
}

#############################################################################
# BUDGETS
#############################################################################
variable "budgets" {
  description = "value to set the budgets"
  type = map(object({
    budget_name           = string
    scope_type            = string
    amount                = number
    time_grain            = string
    start_date            = string
    end_date              = optional(string)
    management_group_name = optional(string)
    management_group_id   = optional(string)
    subscription_id       = optional(string)
    resource_group_name   = optional(string)
    resource_group_id     = optional(string)
    notifications = optional(map(object({
      enabled        = bool
      operator       = string
      threshold      = number
      threshold_type = optional(string)
      contact_emails = optional(list(string))
    })))
  }))
  default = {}
}

#############################################################################
# POLICY DEFINITIONS
#############################################################################
variable "policy_definitions" {
  description = "value to set the policy definitions"
  type = map(object({
    policy_definition_name = string
    display_name           = string
    description            = optional(string)
    policy_type            = optional(string)
    mode                   = optional(string)
    management_group_name  = optional(string)
    management_group_id    = optional(string)
    metadata               = optional(any)
    parameters             = optional(any)
    policy_rule            = any
  }))
  default = {}
}

#############################################################################
# POLICY SET DEFINITIONS
#############################################################################
variable "policy_set_definitions" {
  description = "value to set the policy set definitions"
  type = map(object({
    policy_set_definition_name = string
    display_name               = string
    description                = optional(string)
    policy_type                = optional(string)
    management_group_name      = optional(string)
    management_group_id        = optional(string)
    metadata                   = optional(any)
    parameters                 = optional(any)
    policy_definitions = list(object({
      policy_definition_id   = optional(string)
      policy_definition_name = optional(string)
      reference_id           = optional(string)
      parameter_values       = optional(any)
    }))
  }))
  default = {}
}

#############################################################################
# POLICY ASSIGNMENTS
#############################################################################
variable "policy_assignments" {
  description = "value to set the policy assignments"
  type = map(object({
    scope_type                 = string
    scope_id                   = optional(string)
    resource_group_name        = optional(string)
    management_group_name      = optional(string)
    policy_assignment_name     = string
    display_name               = optional(string)
    description                = optional(string)
    policy_definition_id       = optional(string)
    policy_definition_name     = optional(string)
    policy_set_definition_name = optional(string)
    parameters                 = optional(any)
    location                   = optional(string)
    identity_type              = optional(string)
    identity_ids               = optional(list(string))
    not_scopes                 = optional(list(string))
    enforce                    = optional(bool)
    metadata                   = optional(any)
  }))
  default = {}
}

#############################################################################
# POLICY EXEMPTIONS
#############################################################################
variable "policy_exemptions" {
  description = "value to set the policy exemptions"
  type = map(object({
    scope_type                      = string
    scope_id                        = optional(string)
    resource_group_name             = optional(string)
    management_group_name           = optional(string)
    policy_exemption_name           = string
    policy_assignment_id            = optional(string)
    policy_assignment_name          = optional(string)
    exemption_category              = optional(string)
    display_name                    = optional(string)
    description                     = optional(string)
    expires_on                      = optional(string)
    metadata                        = optional(any)
    policy_definition_reference_ids = optional(list(string))
  }))
  default = {}
}

#############################################################################
# POLICY REMEDIATIONS
#############################################################################
variable "policy_remediations" {
  description = "value to set the policy remediations"
  type = map(object({
    remediation_name               = string
    scope_type                     = string
    scope_id                       = optional(string)
    resource_group_name            = optional(string)
    management_group_name          = optional(string)
    subscription_id                = optional(string)
    policy_assignment_id           = optional(string)
    policy_assignment_name         = optional(string)
    policy_definition_reference_id = optional(string)
  }))
  default = {}
}

#############################################################################
# MONITOR ACTION GROUPS
#############################################################################
variable "monitor_action_groups" {
  description = "value to set the monitor action groups"
  type = map(object({
    action_group_name   = string
    short_name          = string
    resource_group_name = optional(string)
    enabled             = optional(bool)
    email_receivers = optional(list(object({
      name                    = string
      email_address           = string
      use_common_alert_schema = optional(bool)
    })))
    webhook_receivers = optional(list(object({
      name                    = string
      service_uri             = string
      use_common_alert_schema = optional(bool)
    })))
    arm_role_receivers = optional(list(object({
      name                    = string
      role_id                 = string
      use_common_alert_schema = optional(bool)
    })))
  }))
  default = {}
}

#############################################################################
# ACTIVITY LOG ALERTS
#############################################################################
variable "activity_log_alerts" {
  description = "value to set the activity log alerts"
  type = map(object({
    activity_log_alert_name = string
    resource_group_name     = optional(string)
    location                = optional(string)
    scopes                  = list(string)
    operation_name          = optional(string)
    category                = optional(string)
    level                   = optional(string)
    status                  = optional(string)
    action_group_ids        = optional(list(string))
    action_group_names      = optional(list(string))
    description             = optional(string)
    enabled                 = optional(bool)
  }))
  default = {}
}

#############################################################################
# RESOURCE PROVIDER REGISTRATIONS
#############################################################################
variable "resource_provider_registrations" {
  description = "value to set the resource provider registrations"
  type = map(object({
    resource_provider_name = string
  }))
  default = {}
}
