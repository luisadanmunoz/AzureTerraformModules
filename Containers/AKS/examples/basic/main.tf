################################################################################
# Example: AKS Cluster
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

resource "azurerm_resource_group" "example" {
  name     = "rg-aks-dev-001"
  location = "westeurope"
}

resource "azurerm_virtual_network" "example" {
  name                = "vnet-aks-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "aks" {
  name                 = "snet-aks"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.0.0/22"]
}

resource "azurerm_log_analytics_workspace" "example" {
  name                = "log-aks-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "PerGB2018"
}

module "aks" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "demo"
  environment = "dev"

  kubernetes_version = "1.28"
  sku_tier           = "Free"

  default_node_pool = {
    name           = "system"
    vm_size        = "Standard_D2s_v5"
    min_count      = 1
    max_count      = 3
    vnet_subnet_id = azurerm_subnet.aks.id
  }

  node_pools = [
    {
      name           = "workload"
      vm_size        = "Standard_D4s_v5"
      min_count      = 1
      max_count      = 5
      vnet_subnet_id = azurerm_subnet.aks.id
      node_labels = {
        "workload" = "apps"
      }
    }
  ]

  network_profile = {
    network_plugin = "azure"
    network_policy = "azure"
  }

  oms_agent = {
    enabled                    = true
    log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
  }

  tags = {
    Environment = "Development"
    Project     = "Demo"
  }
}

output "cluster_id" {
  value = module.aks.id
}

output "cluster_fqdn" {
  value = module.aks.fqdn
}

output "kube_config" {
  value     = module.aks.kube_config_raw
  sensitive = true
}

output "get_credentials" {
  value = "az aks get-credentials --resource-group ${azurerm_resource_group.example.name} --name ${module.aks.name}"
}
