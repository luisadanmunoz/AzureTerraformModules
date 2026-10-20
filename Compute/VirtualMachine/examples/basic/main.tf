################################################################################
# Example: Virtual Machines
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

# ──────────────────────────────────────────────────────────────────────────────
# Resource Group
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_resource_group" "example" {
  name     = "rg-compute-dev-001"
  location = "westeurope"
}

# ──────────────────────────────────────────────────────────────────────────────
# Networking
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_virtual_network" "example" {
  name                = "vnet-compute-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "example" {
  name                 = "snet-vms"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# ──────────────────────────────────────────────────────────────────────────────
# Linux VM with SSH
# ──────────────────────────────────────────────────────────────────────────────

module "linux_vm" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "web"
  environment = "dev"

  os_type   = "Linux"
  size      = "Standard_D2s_v5"
  subnet_id = azurerm_subnet.example.id

  admin_username                  = "adminuser"
  disable_password_authentication = false # Allow password for demo

  source_image_reference = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk = {
    storage_account_type = "Premium_LRS"
    disk_size_gb         = 64
  }

  # Trusted Launch
  secure_boot_enabled = true
  vtpm_enabled        = true

  identity = {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
    Role        = "WebServer"
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Windows VM with Data Disks
# ──────────────────────────────────────────────────────────────────────────────

module "windows_vm" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = "vm-sql-dev-001"

  os_type   = "Windows"
  size      = "Standard_D4s_v5"
  subnet_id = azurerm_subnet.example.id
  zone      = "1"

  admin_username = "sqladmin"
  # Password will be auto-generated

  source_image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-g2"
    version   = "latest"
  }

  os_disk = {
    storage_account_type = "Premium_LRS"
    disk_size_gb         = 128
  }

  # Data disks for SQL
  data_disks = [
    {
      lun                  = 0
      disk_size_gb         = 256
      storage_account_type = "Premium_LRS"
      caching              = "ReadOnly"
    },
    {
      lun                  = 1
      disk_size_gb         = 128
      storage_account_type = "Premium_LRS"
      caching              = "None"
    }
  ]

  # Trusted Launch
  secure_boot_enabled = true
  vtpm_enabled        = true

  # Update management
  patch_mode = "AutomaticByPlatform"

  identity = {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
    Role        = "SQLServer"
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Spot VM for Dev/Test
# ──────────────────────────────────────────────────────────────────────────────

module "spot_vm" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "batch"
  environment = "dev"

  os_type   = "Linux"
  size      = "Standard_D8s_v5"
  subnet_id = azurerm_subnet.example.id

  admin_username = "batchuser"

  # Spot configuration
  priority        = "Spot"
  eviction_policy = "Deallocate"
  max_bid_price   = -1 # Pay up to on-demand price

  source_image_reference = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
  }

  tags = {
    Environment = "Development"
    Type        = "SpotInstance"
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Outputs
# ──────────────────────────────────────────────────────────────────────────────

output "linux_vm_id" {
  description = "Linux VM ID"
  value       = module.linux_vm.id
}

output "linux_vm_private_ip" {
  description = "Linux VM private IP"
  value       = module.linux_vm.private_ip_address
}

output "linux_vm_password" {
  description = "Linux VM admin password"
  value       = module.linux_vm.admin_password
  sensitive   = true
}

output "windows_vm_id" {
  description = "Windows VM ID"
  value       = module.windows_vm.id
}

output "windows_vm_private_ip" {
  description = "Windows VM private IP"
  value       = module.windows_vm.private_ip_address
}

output "windows_vm_password" {
  description = "Windows VM admin password"
  value       = module.windows_vm.admin_password
  sensitive   = true
}

output "spot_vm_id" {
  description = "Spot VM ID"
  value       = module.spot_vm.id
}
