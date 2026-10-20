################################################################################
# Example: Azure Policy Set Definition (Initiative)
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

################################################################################
# Data Sources - Built-in Policies
################################################################################

data "azurerm_policy_definition" "allowed_locations" {
  display_name = "Allowed locations"
}

data "azurerm_policy_definition" "require_tag" {
  display_name = "Require a tag on resources"
}

data "azurerm_policy_definition" "storage_https" {
  display_name = "Secure transfer to storage accounts should be enabled"
}

data "azurerm_policy_definition" "sql_tls" {
  display_name = "Azure SQL Database should have the minimal TLS version of 1.2"
}

################################################################################
# Security Baseline Initiative
# Best Practice: Group security policies for consistent enforcement
################################################################################

module "security_baseline" {
  source = "../../"

  name         = "security-baseline-v1"
  display_name = "Security Baseline v1.0"
  description  = "Core security policies for all Azure resources"

  metadata = jsonencode({
    version  = "1.0.0"
    category = "Security"
  })

  policy_definition_groups = [
    {
      name         = "Encryption"
      display_name = "Encryption Policies"
      description  = "Policies ensuring data encryption"
      category     = "Data Protection"
    },
    {
      name         = "Network"
      display_name = "Network Security"
      description  = "Policies for network security"
      category     = "Network"
    }
  ]

  policy_definitions = [
    {
      policy_definition_id = data.azurerm_policy_definition.storage_https.id
      reference_id         = "storageSecureTransfer"
      policy_group_names   = ["Encryption", "Network"]
    },
    {
      policy_definition_id = data.azurerm_policy_definition.sql_tls.id
      reference_id         = "sqlTls12"
      policy_group_names   = ["Encryption"]
    }
  ]
}

################################################################################
# Governance Baseline Initiative
# Best Practice: Combine tagging and location policies
################################################################################

module "governance_baseline" {
  source = "../../"

  name         = "governance-baseline-v1"
  display_name = "Governance Baseline v1.0"
  description  = "Organization governance policies for cost management and compliance"

  metadata = jsonencode({
    version  = "1.0.0"
    category = "Governance"
  })

  parameters = jsonencode({
    allowedLocations = {
      type = "Array"
      metadata = {
        displayName = "Allowed Locations"
        description = "Locations where resources can be deployed"
        strongType  = "location"
      }
      defaultValue = ["westeurope", "northeurope"]
    }
    requiredTag1 = {
      type = "String"
      metadata = {
        displayName = "Required Tag 1"
        description = "First required tag name"
      }
      defaultValue = "CostCenter"
    }
    requiredTag2 = {
      type = "String"
      metadata = {
        displayName = "Required Tag 2"
        description = "Second required tag name"
      }
      defaultValue = "Owner"
    }
  })

  policy_definition_groups = [
    {
      name         = "Tagging"
      display_name = "Tagging Policies"
      description  = "Policies for resource tagging"
      category     = "Tags"
    },
    {
      name         = "Locations"
      display_name = "Location Policies"
      description  = "Policies for allowed locations"
      category     = "General"
    }
  ]

  policy_definitions = [
    {
      policy_definition_id = data.azurerm_policy_definition.allowed_locations.id
      reference_id         = "allowedLocations"
      policy_group_names   = ["Locations"]
      parameter_values     = jsonencode({
        listOfAllowedLocations = { value = "[parameters('allowedLocations')]" }
      })
    },
    {
      policy_definition_id = data.azurerm_policy_definition.require_tag.id
      reference_id         = "requireTag1"
      policy_group_names   = ["Tagging"]
      parameter_values     = jsonencode({
        tagName = { value = "[parameters('requiredTag1')]" }
      })
    },
    {
      policy_definition_id = data.azurerm_policy_definition.require_tag.id
      reference_id         = "requireTag2"
      policy_group_names   = ["Tagging"]
      parameter_values     = jsonencode({
        tagName = { value = "[parameters('requiredTag2')]" }
      })
    }
  ]
}

################################################################################
# Outputs
################################################################################

output "security_baseline_id" {
  value = module.security_baseline.id
}

output "governance_baseline_id" {
  value = module.governance_baseline.id
}
