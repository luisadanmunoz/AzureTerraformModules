################################################################################
# Example: Basic AVD Scaling Plan
################################################################################

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.70.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# ──────────────────────────────────────────────────────────────────────────────
# Resource Group
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_resource_group" "example" {
  name     = "rg-avd-dev-001"
  location = "westeurope"
}

# ──────────────────────────────────────────────────────────────────────────────
# Host Pool
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_virtual_desktop_host_pool" "example" {
  name                = "vdpool-example-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  type                     = "Pooled"
  load_balancer_type       = "BreadthFirst"
  maximum_sessions_allowed = 10
}

# ──────────────────────────────────────────────────────────────────────────────
# Scaling Plan Module
# ──────────────────────────────────────────────────────────────────────────────

module "scaling_plan" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = "vdscaling-business-dev-001"

  friendly_name = "Business Hours Scaling"
  description   = "Scales hosts based on business hours"
  time_zone     = "UTC"

  # Associate with host pool
  host_pool_associations = [
    {
      hostpool_id = azurerm_virtual_desktop_host_pool.example.id
      enabled     = true
    }
  ]

  # Define schedules
  schedules = [
    {
      name         = "Weekdays"
      days_of_week = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]

      # Ramp-up: 7 AM
      ramp_up_start_time                 = "07:00"
      ramp_up_load_balancing_algorithm   = "BreadthFirst"
      ramp_up_minimum_hosts_percent      = 25
      ramp_up_capacity_threshold_percent = 60

      # Peak: 9 AM - 5 PM
      peak_start_time               = "09:00"
      peak_load_balancing_algorithm = "BreadthFirst"

      # Ramp-down: 5 PM
      ramp_down_start_time                 = "17:00"
      ramp_down_load_balancing_algorithm   = "DepthFirst"
      ramp_down_minimum_hosts_percent      = 10
      ramp_down_capacity_threshold_percent = 90
      ramp_down_force_logoff_users         = false
      ramp_down_wait_time_minutes          = 30
      ramp_down_notification_message       = "Your session will end in 30 minutes. Please save your work."
      ramp_down_stop_hosts_when            = "ZeroSessions"

      # Off-peak: 8 PM
      off_peak_start_time               = "20:00"
      off_peak_load_balancing_algorithm = "DepthFirst"
    },
    {
      name         = "Weekend"
      days_of_week = ["Saturday", "Sunday"]

      ramp_up_start_time                 = "09:00"
      ramp_up_minimum_hosts_percent      = 10
      ramp_up_capacity_threshold_percent = 80

      peak_start_time = "10:00"

      ramp_down_start_time         = "16:00"
      ramp_down_force_logoff_users = true
      ramp_down_wait_time_minutes  = 15
      ramp_down_stop_hosts_when    = "ZeroSessions"

      off_peak_start_time = "18:00"
    }
  ]

  tags = {
    Environment = "Development"
    Purpose     = "CostOptimization"
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Outputs
# ──────────────────────────────────────────────────────────────────────────────

output "scaling_plan_id" {
  description = "The ID of the Scaling Plan"
  value       = module.scaling_plan.id
}

output "scaling_plan_name" {
  description = "The name of the Scaling Plan"
  value       = module.scaling_plan.name
}

output "schedule_names" {
  description = "The schedule names"
  value       = module.scaling_plan.schedule_names
}
