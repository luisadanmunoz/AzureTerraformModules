################################################################################
# Example: Azure Management Group Hierarchy
# Following Microsoft Cloud Adoption Framework
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

################################################################################
# Enterprise-Scale Management Group Structure
# Based on Microsoft Cloud Adoption Framework
################################################################################

# Organization root
module "mg_organization" {
  source = "../../"

  name         = "mg-contoso"
  display_name = "Contoso Organization"
}

################################################################################
# Platform Management Groups
# For shared services and infrastructure
################################################################################

module "mg_platform" {
  source = "../../"

  name                       = "mg-platform"
  display_name               = "Platform"
  parent_management_group_id = module.mg_organization.id
}

module "mg_identity" {
  source = "../../"

  name                       = "mg-identity"
  display_name               = "Identity"
  parent_management_group_id = module.mg_platform.id
}

module "mg_management" {
  source = "../../"

  name                       = "mg-management"
  display_name               = "Management"
  parent_management_group_id = module.mg_platform.id
}

module "mg_connectivity" {
  source = "../../"

  name                       = "mg-connectivity"
  display_name               = "Connectivity"
  parent_management_group_id = module.mg_platform.id
}

################################################################################
# Landing Zones Management Groups
# For workload subscriptions
################################################################################

module "mg_landingzones" {
  source = "../../"

  name                       = "mg-landingzones"
  display_name               = "Landing Zones"
  parent_management_group_id = module.mg_organization.id
}

module "mg_corp" {
  source = "../../"

  name                       = "mg-corp"
  display_name               = "Corp (Internal)"
  parent_management_group_id = module.mg_landingzones.id
}

module "mg_online" {
  source = "../../"

  name                       = "mg-online"
  display_name               = "Online (External)"
  parent_management_group_id = module.mg_landingzones.id
}

################################################################################
# Sandbox and Decommissioned
################################################################################

module "mg_sandbox" {
  source = "../../"

  name                       = "mg-sandbox"
  display_name               = "Sandbox"
  parent_management_group_id = module.mg_organization.id
}

module "mg_decommissioned" {
  source = "../../"

  name                       = "mg-decommissioned"
  display_name               = "Decommissioned"
  parent_management_group_id = module.mg_organization.id
}

################################################################################
# Outputs
################################################################################

output "organization_id" {
  value = module.mg_organization.id
}

output "platform_id" {
  value = module.mg_platform.id
}

output "landingzones_id" {
  value = module.mg_landingzones.id
}

output "hierarchy" {
  value = {
    organization = module.mg_organization.name
    platform = {
      id         = module.mg_platform.id
      identity   = module.mg_identity.id
      management = module.mg_management.id
      connectivity = module.mg_connectivity.id
    }
    landingzones = {
      id     = module.mg_landingzones.id
      corp   = module.mg_corp.id
      online = module.mg_online.id
    }
    sandbox        = module.mg_sandbox.id
    decommissioned = module.mg_decommissioned.id
  }
}
