################################################################################
# Example: Azure ML Compute Instance
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

data "azurerm_machine_learning_workspace" "existing" {
  name                = "mlw-prod-001"
  resource_group_name = "rg-ml-workspace"
}

module "compute_instance" {
  source = "../../"

  name                          = "ci-dev-001"
  machine_learning_workspace_id = data.azurerm_machine_learning_workspace.existing.id
  virtual_machine_size          = "Standard_DS3_v2"

  description = "Development compute instance"

  tags = {
    Environment = "Development"
    Owner       = "DataScience"
  }
}

output "instance_id" {
  value = module.compute_instance.id
}
