################################################################################
# Basic Example - Hybrid Worker Group Module
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
  name                = "aa-hybrid-example-dev-001"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "Basic"

  identity {
    type = "SystemAssigned"
  }
}

################################################################################
# Hybrid Worker Groups
################################################################################

module "hybrid_worker_groups" {
  source = "../../"

  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name

  hybrid_worker_groups = {
    "WindowsWorkers" = {
      # No credential - use Managed Identity
    }
    "LinuxWorkers" = {
      # No credential - use Managed Identity
    }
    "OnPremWorkers" = {
      # Credential would be specified here if needed
      # credential_name = "OnPremCredential"
    }
  }

  # Note: To add actual VMs as workers, uncomment and configure:
  # hybrid_workers = {
  #   "worker-01" = {
  #     group_name     = "WindowsWorkers"
  #     vm_resource_id = "/subscriptions/xxx/resourceGroups/rg/providers/Microsoft.Compute/virtualMachines/vm-worker-01"
  #   }
  # }
}

################################################################################
# Outputs
################################################################################

output "group_ids" {
  value = module.hybrid_worker_groups.group_ids
}

output "group_names" {
  value = module.hybrid_worker_groups.group_names
}
