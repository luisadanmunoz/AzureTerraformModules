################################################################################
# Example: Virtual Machine Scale Sets
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
  name     = "rg-vmss-dev-001"
  location = "westeurope"
}

# ──────────────────────────────────────────────────────────────────────────────
# Networking
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_virtual_network" "example" {
  name                = "vnet-vmss-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "example" {
  name                 = "snet-vmss"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# ──────────────────────────────────────────────────────────────────────────────
# Linux VMSS with Autoscaling
# ──────────────────────────────────────────────────────────────────────────────

module "vmss_linux" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "web"
  environment = "dev"

  os_type   = "Linux"
  sku       = "Standard_D2s_v5"
  instances = 2
  subnet_id = azurerm_subnet.example.id
  zones     = ["1", "2", "3"]

  admin_username                  = "adminuser"
  disable_password_authentication = false

  source_image_reference = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk = {
    storage_account_type = "Premium_LRS"
  }

  # Autoscaling
  autoscale = {
    enabled                 = true
    min_count               = 2
    max_count               = 6
    default_count           = 2
    scale_out_cpu_threshold = 70
    scale_in_cpu_threshold  = 30
  }

  # Trusted Launch
  secure_boot_enabled = true
  vtpm_enabled        = true

  identity = {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
    Role        = "WebFrontend"
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Windows VMSS
# ──────────────────────────────────────────────────────────────────────────────

module "vmss_windows" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = "vmss-iis-dev-001"

  os_type   = "Windows"
  sku       = "Standard_D4s_v5"
  instances = 2
  subnet_id = azurerm_subnet.example.id

  admin_username = "winadmin"

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

  # Trusted Launch
  secure_boot_enabled = true
  vtpm_enabled        = true

  identity = {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
    Role        = "IISServer"
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Outputs
# ──────────────────────────────────────────────────────────────────────────────

output "linux_vmss_id" {
  description = "Linux VMSS ID"
  value       = module.vmss_linux.id
}

output "linux_vmss_password" {
  description = "Linux VMSS admin password"
  value       = module.vmss_linux.admin_password
  sensitive   = true
}

output "linux_vmss_autoscale_id" {
  description = "Linux VMSS autoscale setting ID"
  value       = module.vmss_linux.autoscale_setting_id
}

output "windows_vmss_id" {
  description = "Windows VMSS ID"
  value       = module.vmss_windows.id
}

output "windows_vmss_password" {
  description = "Windows VMSS admin password"
  value       = module.vmss_windows.admin_password
  sensitive   = true
}
