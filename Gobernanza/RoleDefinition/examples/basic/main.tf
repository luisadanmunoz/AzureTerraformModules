################################################################################
# Example: Azure Custom Role Definitions
# Following Microsoft RBAC Best Practices
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

################################################################################
# VM Operator Role
# Best Practice: Granular permissions for VM operations
################################################################################

module "vm_operator" {
  source = "../../"

  name        = "VM Operator"
  scope       = data.azurerm_subscription.current.id
  description = "Can start, stop, and restart VMs but not create or delete them"

  permissions = [
    {
      actions = [
        "Microsoft.Compute/virtualMachines/read",
        "Microsoft.Compute/virtualMachines/start/action",
        "Microsoft.Compute/virtualMachines/powerOff/action",
        "Microsoft.Compute/virtualMachines/restart/action",
        "Microsoft.Compute/virtualMachines/instanceView/read",
        "Microsoft.Resources/subscriptions/resourceGroups/read"
      ]
    }
  ]
}

################################################################################
# Cost Reader Role
# Best Practice: Separate cost visibility from resource management
################################################################################

module "cost_reader" {
  source = "../../"

  name        = "Cost Reader"
  scope       = data.azurerm_subscription.current.id
  description = "Can view costs and budgets without resource access"

  permissions = [
    {
      actions = [
        "Microsoft.Consumption/*/read",
        "Microsoft.CostManagement/*/read",
        "Microsoft.Billing/billingPeriods/read",
        "Microsoft.Resources/subscriptions/read",
        "Microsoft.Resources/subscriptions/resourceGroups/read",
        "Microsoft.Support/*"
      ]
    }
  ]
}

################################################################################
# Storage Data Processor
# Best Practice: Data plane permissions for processing workloads
################################################################################

module "storage_processor" {
  source = "../../"

  name        = "Storage Data Processor"
  scope       = data.azurerm_subscription.current.id
  description = "Can read and write blob data for data processing pipelines"

  permissions = [
    {
      # Control plane - read only
      actions = [
        "Microsoft.Storage/storageAccounts/read",
        "Microsoft.Storage/storageAccounts/blobServices/containers/read"
      ]
      # Data plane - read and write blobs
      data_actions = [
        "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read",
        "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write",
        "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/move/action"
      ]
      # Prevent deletion
      not_data_actions = [
        "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/delete"
      ]
    }
  ]
}

################################################################################
# DevOps Engineer Role
# Best Practice: Broad permissions with explicit exclusions
################################################################################

module "devops_engineer" {
  source = "../../"

  name        = "DevOps Engineer"
  scope       = data.azurerm_subscription.current.id
  description = "Can manage most resources except IAM and core networking"

  permissions = [
    {
      actions = [
        "Microsoft.Compute/*",
        "Microsoft.ContainerRegistry/*",
        "Microsoft.ContainerService/*",
        "Microsoft.KeyVault/vaults/read",
        "Microsoft.KeyVault/vaults/secrets/read",
        "Microsoft.OperationalInsights/*",
        "Microsoft.Resources/*",
        "Microsoft.Storage/*",
        "Microsoft.Web/*"
      ]
      not_actions = [
        # Prevent IAM changes
        "Microsoft.Authorization/*/Delete",
        "Microsoft.Authorization/*/Write",
        "Microsoft.Authorization/elevateAccess/Action",
        # Prevent core network changes
        "Microsoft.Network/virtualNetworks/delete",
        "Microsoft.Network/virtualNetworks/write",
        "Microsoft.Network/virtualNetworkGateways/*",
        "Microsoft.Network/expressRouteCircuits/*"
      ]
    }
  ]
}

################################################################################
# Key Vault Secrets Reader
# Best Practice: Minimal Key Vault access for applications
################################################################################

module "keyvault_secrets_reader" {
  source = "../../"

  name        = "Key Vault Secrets Reader"
  scope       = data.azurerm_subscription.current.id
  description = "Can read Key Vault secrets for application configuration"

  permissions = [
    {
      actions = [
        "Microsoft.KeyVault/vaults/read"
      ]
      data_actions = [
        "Microsoft.KeyVault/vaults/secrets/getSecret/action",
        "Microsoft.KeyVault/vaults/secrets/readMetadata/action"
      ]
      not_data_actions = [
        "Microsoft.KeyVault/vaults/secrets/setSecret/action",
        "Microsoft.KeyVault/vaults/secrets/delete"
      ]
    }
  ]
}

################################################################################
# Outputs
################################################################################

output "vm_operator_id" {
  value = module.vm_operator.role_definition_id
}

output "cost_reader_id" {
  value = module.cost_reader.role_definition_id
}

output "storage_processor_id" {
  value = module.storage_processor.role_definition_id
}

output "devops_engineer_id" {
  value = module.devops_engineer.role_definition_id
}

output "keyvault_reader_id" {
  value = module.keyvault_secrets_reader.role_definition_id
}
