################################################################################
# Example: Azure Policy Definition
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
# Policy: Require Tags
# Best Practice: Enforce tagging for cost management and organization
################################################################################

module "policy_require_tags" {
  source = "../../"

  name         = "require-mandatory-tags"
  display_name = "Require Mandatory Tags on Resources"
  description  = "Ensures all resources have mandatory tags: Environment, CostCenter, Owner"
  mode         = "Indexed"

  metadata = jsonencode({
    version  = "1.0.0"
    category = "Tags"
  })

  parameters = jsonencode({
    tagName = {
      type = "String"
      metadata = {
        displayName = "Tag Name"
        description = "Name of the tag to require"
      }
    }
  })

  policy_rule = jsonencode({
    if = {
      field  = "[concat('tags[', parameters('tagName'), ']')]"
      exists = "false"
    }
    then = {
      effect = "deny"
    }
  })
}

################################################################################
# Policy: Allowed Locations
# Best Practice: Restrict deployments to approved regions for compliance
################################################################################

module "policy_allowed_locations" {
  source = "../../"

  name         = "allowed-locations-europe"
  display_name = "Allowed Locations - Europe"
  description  = "Restrict resource deployment to European regions for GDPR compliance"
  mode         = "Indexed"

  metadata = jsonencode({
    version  = "1.0.0"
    category = "General"
  })

  parameters = jsonencode({
    allowedLocations = {
      type = "Array"
      metadata = {
        displayName = "Allowed locations"
        description = "The list of allowed locations for resources"
        strongType  = "location"
      }
      defaultValue = [
        "westeurope",
        "northeurope",
        "francecentral",
        "germanywestcentral"
      ]
    }
  })

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field    = "location"
          notIn    = "[parameters('allowedLocations')]"
        },
        {
          field    = "location"
          notEquals = "global"
        }
      ]
    }
    then = {
      effect = "deny"
    }
  })
}

################################################################################
# Policy: Require HTTPS on Storage
# Best Practice: Enforce secure transfer for data protection
################################################################################

module "policy_storage_https" {
  source = "../../"

  name         = "storage-require-https"
  display_name = "Storage Accounts Should Require HTTPS"
  description  = "Audit or deny storage accounts that do not require HTTPS"
  mode         = "Indexed"

  metadata = jsonencode({
    version  = "1.0.0"
    category = "Storage"
  })

  parameters = jsonencode({
    effect = {
      type = "String"
      metadata = {
        displayName = "Effect"
        description = "The effect to apply when the policy is triggered"
      }
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Deny"
    }
  })

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field  = "type"
          equals = "Microsoft.Storage/storageAccounts"
        },
        {
          field    = "Microsoft.Storage/storageAccounts/supportsHttpsTrafficOnly"
          notEquals = true
        }
      ]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
}

################################################################################
# Policy: Inherit Tag from Resource Group
# Best Practice: Automatic tag inheritance for consistent tagging
################################################################################

module "policy_inherit_tag" {
  source = "../../"

  name         = "inherit-tag-from-rg"
  display_name = "Inherit Tag from Resource Group"
  description  = "Automatically inherit specified tag from resource group if missing"
  mode         = "Indexed"

  metadata = jsonencode({
    version  = "1.0.0"
    category = "Tags"
  })

  parameters = jsonencode({
    tagName = {
      type = "String"
      metadata = {
        displayName = "Tag Name"
        description = "Name of the tag to inherit from resource group"
      }
    }
  })

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field  = "[concat('tags[', parameters('tagName'), ']')]"
          exists = "false"
        },
        {
          value    = "[resourceGroup().tags[parameters('tagName')]]"
          notEquals = ""
        }
      ]
    }
    then = {
      effect = "modify"
      details = {
        roleDefinitionIds = [
          "/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"
        ]
        operations = [
          {
            operation = "add"
            field     = "[concat('tags[', parameters('tagName'), ']')]"
            value     = "[resourceGroup().tags[parameters('tagName')]]"
          }
        ]
      }
    }
  })
}

################################################################################
# Outputs
################################################################################

output "require_tags_policy_id" {
  value = module.policy_require_tags.id
}

output "allowed_locations_policy_id" {
  value = module.policy_allowed_locations.id
}

output "storage_https_policy_id" {
  value = module.policy_storage_https.id
}

output "inherit_tag_policy_id" {
  value = module.policy_inherit_tag.id
}
