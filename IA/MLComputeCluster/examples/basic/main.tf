################################################################################
# Example: Azure ML Compute Cluster
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

################################################################################
# CPU Training Cluster
################################################################################

module "cpu_cluster" {
  source = "../../"

  name                          = "cc-cpu-training"
  machine_learning_workspace_id = data.azurerm_machine_learning_workspace.existing.id
  location                      = "westeurope"
  vm_size                       = "Standard_DS3_v2"
  vm_priority                   = "Dedicated"

  min_node_count                       = 0
  max_node_count                       = 4
  scale_down_nodes_after_idle_duration = "PT15M"

  tags = {
    Purpose = "CPUTraining"
  }
}

################################################################################
# GPU Training Cluster
################################################################################

module "gpu_cluster" {
  source = "../../"

  name                          = "cc-gpu-training"
  machine_learning_workspace_id = data.azurerm_machine_learning_workspace.existing.id
  location                      = "westeurope"
  vm_size                       = "Standard_NC6"
  vm_priority                   = "LowPriority"

  min_node_count = 0
  max_node_count = 8

  tags = {
    Purpose = "GPUTraining"
  }
}

################################################################################
# Outputs
################################################################################

output "cpu_cluster_id" {
  value = module.cpu_cluster.id
}

output "gpu_cluster_id" {
  value = module.gpu_cluster.id
}
