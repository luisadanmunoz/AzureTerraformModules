################################################################################
# Basic Example - Automation Schedule Module
################################################################################

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.70.0, < 5.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "rg-automation-example-dev-001"
  location = "westeurope"
}

resource "azurerm_automation_account" "example" {
  name                = "aa-schedules-example-dev-001"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "Basic"
}

################################################################################
# Daily Schedule - Every day at 6 AM
################################################################################

module "schedule_daily" {
  source = "../../"

  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  name                    = "daily-6am"
  description             = "Runs every day at 6 AM"

  frequency  = "Day"
  interval   = 1
  start_time = timeadd(timestamp(), "24h")
  timezone   = "Europe/Madrid"

  lifecycle {
    ignore_changes = [start_time]
  }
}

################################################################################
# Weekly Schedule - Weekdays at 8 AM
################################################################################

module "schedule_weekdays" {
  source = "../../"

  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  name                    = "weekdays-8am"
  description             = "Runs on weekdays at 8 AM"

  frequency  = "Week"
  interval   = 1
  start_time = timeadd(timestamp(), "24h")
  timezone   = "Europe/Madrid"

  week_days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]

  lifecycle {
    ignore_changes = [start_time]
  }
}

################################################################################
# Monthly Schedule - First Monday of each month
################################################################################

module "schedule_first_monday" {
  source = "../../"

  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  name                    = "first-monday"
  description             = "Runs on first Monday of each month"

  frequency  = "Month"
  interval   = 1
  start_time = timeadd(timestamp(), "24h")
  timezone   = "UTC"

  monthly_occurrence = {
    day        = "Monday"
    occurrence = 1
  }

  lifecycle {
    ignore_changes = [start_time]
  }
}

################################################################################
# Hourly Schedule - Every 4 hours
################################################################################

module "schedule_hourly" {
  source = "../../"

  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  name                    = "every-4-hours"
  description             = "Runs every 4 hours"

  frequency  = "Hour"
  interval   = 4
  start_time = timeadd(timestamp(), "1h")
  timezone   = "UTC"

  lifecycle {
    ignore_changes = [start_time]
  }
}

################################################################################
# Outputs
################################################################################

output "daily_schedule_id" {
  value = module.schedule_daily.id
}

output "weekdays_schedule_id" {
  value = module.schedule_weekdays.id
}

output "first_monday_schedule_id" {
  value = module.schedule_first_monday.id
}

output "hourly_schedule_id" {
  value = module.schedule_hourly.id
}
