################################################################################
# Example: Azure Consumption Budgets
# Following Microsoft FinOps Best Practices
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

data "azurerm_subscription" "current" {}

resource "azurerm_resource_group" "example" {
  name     = "rg-budget-demo-001"
  location = "westeurope"

  tags = {
    Environment = "Development"
    CostCenter  = "IT-001"
  }
}

################################################################################
# Subscription Budget
# Best Practice: Set overall subscription spending limits
################################################################################

module "subscription_budget" {
  source = "../../"

  name       = "subscription-monthly-budget"
  amount     = 50000
  time_grain = "Monthly"
  scope_type = "subscription"

  time_period = {
    start_date = "2024-01-01T00:00:00Z"
  }

  # Best Practice: Multiple threshold notifications
  notifications = [
    {
      threshold      = 50
      threshold_type = "Forecasted"
      operator       = "GreaterThan"
      contact_emails = ["cloudops@company.com"]
    },
    {
      threshold      = 80
      threshold_type = "Actual"
      operator       = "GreaterThanOrEqualTo"
      contact_emails = ["cloudops@company.com", "finance@company.com"]
    },
    {
      threshold      = 100
      threshold_type = "Actual"
      operator       = "GreaterThanOrEqualTo"
      contact_emails = ["cloudops@company.com", "finance@company.com", "cto@company.com"]
      contact_roles  = ["Owner", "Contributor"]
    },
    {
      threshold      = 120
      threshold_type = "Actual"
      operator       = "GreaterThanOrEqualTo"
      contact_emails = ["emergency@company.com"]
    }
  ]
}

################################################################################
# Resource Group Budget
# Best Practice: Granular budgets per project/team
################################################################################

module "project_budget" {
  source = "../../"

  name              = "project-demo-budget"
  amount            = 5000
  time_grain        = "Monthly"
  scope_type        = "resource_group"
  resource_group_id = azurerm_resource_group.example.id

  time_period = {
    start_date = "2024-01-01T00:00:00Z"
  }

  notifications = [
    {
      threshold      = 75
      threshold_type = "Forecasted"
      operator       = "GreaterThan"
      contact_emails = ["project-lead@company.com"]
    },
    {
      threshold      = 90
      threshold_type = "Actual"
      operator       = "GreaterThanOrEqualTo"
      contact_emails = ["project-lead@company.com", "manager@company.com"]
    }
  ]
}

################################################################################
# Filtered Budget by Tag
# Best Practice: Budget by cost center or environment
################################################################################

module "production_budget" {
  source = "../../"

  name       = "production-environment-budget"
  amount     = 30000
  time_grain = "Monthly"
  scope_type = "subscription"

  time_period = {
    start_date = "2024-01-01T00:00:00Z"
  }

  filter = {
    tags = [
      {
        name   = "Environment"
        values = ["Production", "prod"]
      }
    ]
  }

  notifications = [
    {
      threshold      = 80
      operator       = "GreaterThanOrEqualTo"
      contact_emails = ["production-team@company.com"]
    }
  ]
}

################################################################################
# Outputs
################################################################################

output "subscription_budget_id" {
  value = module.subscription_budget.id
}

output "project_budget_id" {
  value = module.project_budget.id
}

output "production_budget_id" {
  value = module.production_budget.id
}
