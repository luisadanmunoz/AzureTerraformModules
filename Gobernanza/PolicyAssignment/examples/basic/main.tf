################################################################################
# Example: Azure Policy Assignment
# Following Microsoft Governance Best Practices
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
  name     = "rg-policy-demo-001"
  location = "westeurope"
}

################################################################################
# Built-in Policy: Allowed Locations
# Best Practice: Restrict deployments to approved regions
################################################################################

data "azurerm_policy_definition" "allowed_locations" {
  display_name = "Allowed locations"
}

module "allowed_locations_assignment" {
  source = "../../"

  name                 = "allowed-locations-sub"
  policy_definition_id = data.azurerm_policy_definition.allowed_locations.id
  display_name         = "Allowed Locations - Europe Only"
  description          = "Restrict deployments to European regions for GDPR compliance"
  scope_type           = "subscription"

  parameters = jsonencode({
    listOfAllowedLocations = {
      value = [
        "westeurope",
        "northeurope",
        "francecentral",
        "germanywestcentral",
        "switzerlandnorth"
      ]
    }
  })

  non_compliance_messages = [
    {
      content = "This location is not allowed. Please deploy to an approved European region: West Europe, North Europe, France Central, Germany West Central, or Switzerland North."
    }
  ]
}

################################################################################
# Built-in Policy: Require Tag
# Best Practice: Enforce tagging for cost management
################################################################################

data "azurerm_policy_definition" "require_tag" {
  display_name = "Require a tag on resources"
}

module "require_costcenter_tag" {
  source = "../../"

  name                 = "require-costcenter-tag"
  policy_definition_id = data.azurerm_policy_definition.require_tag.id
  display_name         = "Require CostCenter Tag"
  description          = "All resources must have a CostCenter tag for cost allocation"
  scope_type           = "subscription"

  parameters = jsonencode({
    tagName = {
      value = "CostCenter"
    }
  })

  # Exclude specific resource groups (e.g., AKS node resource groups)
  not_scopes = [
    "${data.azurerm_subscription.current.id}/resourceGroups/MC_*"
  ]

  non_compliance_messages = [
    {
      content = "Resource must have a 'CostCenter' tag. Please add this tag before deploying."
    }
  ]
}

################################################################################
# Built-in Policy: Inherit Tag from Resource Group
# Best Practice: Automatic tag inheritance with remediation
################################################################################

data "azurerm_policy_definition" "inherit_tag" {
  display_name = "Inherit a tag from the resource group if missing"
}

module "inherit_environment_tag" {
  source = "../../"

  name                 = "inherit-environment-tag"
  policy_definition_id = data.azurerm_policy_definition.inherit_tag.id
  display_name         = "Inherit Environment Tag"
  description          = "Automatically inherit Environment tag from resource group"
  scope_type           = "subscription"
  location             = "westeurope"

  # Identity required for Modify effect
  identity = {
    type = "SystemAssigned"
  }

  parameters = jsonencode({
    tagName = {
      value = "Environment"
    }
  })
}

################################################################################
# Role Assignment for Remediation
# Best Practice: Grant minimal permissions for policy remediation
################################################################################

resource "azurerm_role_assignment" "policy_contributor" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Tag Contributor"
  principal_id         = module.inherit_environment_tag.principal_id
}

################################################################################
# Resource Group Scope Assignment
# Best Practice: Apply stricter policies to production
################################################################################

module "production_storage_https" {
  source = "../../"

  name                 = "storage-https-prod"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/404c3081-a854-4457-ae30-26a93ef643f9"
  display_name         = "Storage HTTPS Only - Production"
  description          = "Storage accounts must use HTTPS in production"
  scope_type           = "resource_group"
  resource_group_id    = azurerm_resource_group.example.id

  # Enforce strictly in production
  enforce = true

  non_compliance_messages = [
    {
      content = "Storage accounts in production must require HTTPS. Please enable 'Secure transfer required'."
    }
  ]
}

################################################################################
# Outputs
################################################################################

output "allowed_locations_assignment_id" {
  value = module.allowed_locations_assignment.id
}

output "require_tag_assignment_id" {
  value = module.require_costcenter_tag.id
}

output "inherit_tag_assignment_id" {
  value = module.inherit_environment_tag.id
}

output "inherit_tag_principal_id" {
  value = module.inherit_environment_tag.principal_id
}
