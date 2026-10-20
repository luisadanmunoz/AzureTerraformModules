# -----------------------------------------------------------------------------
# Basic NFS Volume Example
# -----------------------------------------------------------------------------
# This example demonstrates how to create a basic Azure NetApp Files volume
# with NFSv3 protocol and standard service level.
# -----------------------------------------------------------------------------

provider "azurerm" {
  features {}
}

# -----------------------------------------------------------------------------
# Prerequisites (for reference - these would typically exist already)
# -----------------------------------------------------------------------------

resource "azurerm_resource_group" "example" {
  name     = "rg-netapp-example"
  location = "eastus"
}

resource "azurerm_virtual_network" "example" {
  name                = "vnet-netapp-example"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "netapp" {
  name                 = "snet-netapp"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]

  delegation {
    name = "netapp-delegation"

    service_delegation {
      name    = "Microsoft.NetApp/volumes"
      actions = ["Microsoft.Network/networkinterfaces/*", "Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

resource "azurerm_netapp_account" "example" {
  name                = "netapp-account-example"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_netapp_pool" "example" {
  name                = "netapp-pool-example"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  account_name        = azurerm_netapp_account.example.name
  service_level       = "Standard"
  size_in_tb          = 4
}

# -----------------------------------------------------------------------------
# NetApp Volume Module
# -----------------------------------------------------------------------------

module "netapp_volume" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  account_name        = azurerm_netapp_account.example.name
  pool_name           = azurerm_netapp_pool.example.name

  # Volume configuration
  name        = "vol-nfs-basic"
  volume_path = "nfsbasic"
  subnet_id   = azurerm_subnet.netapp.id

  # Storage configuration
  storage_quota_in_gb = 100
  service_level       = "Standard"
  protocols           = ["NFSv3"]

  # Export policy for NFS access
  export_policy_rules = [
    {
      rule_index          = 1
      allowed_clients     = "10.0.0.0/16"
      protocols_enabled   = ["NFSv3"]
      unix_read_only      = false
      unix_read_write     = true
      root_access_enabled = true
    }
  ]

  tags = {
    Environment = "Example"
    Purpose     = "BasicNFSVolume"
  }
}

# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------

output "volume_id" {
  description = "The ID of the NetApp Volume"
  value       = module.netapp_volume.id
}

output "volume_name" {
  description = "The name of the NetApp Volume"
  value       = module.netapp_volume.name
}

output "volume_path" {
  description = "The file path of the NetApp Volume"
  value       = module.netapp_volume.volume_path
}

output "mount_ip_addresses" {
  description = "IP addresses to use for mounting the volume"
  value       = module.netapp_volume.mount_ip_addresses
}

output "mount_command" {
  description = "Example mount command for the NFS volume"
  value       = "sudo mount -t nfs -o rw,hard,rsize=65536,wsize=65536,vers=3,tcp ${module.netapp_volume.mount_ip_addresses[0]}:/${module.netapp_volume.volume_path} /mnt/netapp"
}
