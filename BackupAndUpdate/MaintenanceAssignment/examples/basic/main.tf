################################################################################
# Example: Maintenance Assignments
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
  name     = "rg-maintenance-dev-001"
  location = "westeurope"
}

# ──────────────────────────────────────────────────────────────────────────────
# Networking
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_virtual_network" "example" {
  name                = "vnet-example-dev-001"
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
# Sample VMs
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_network_interface" "example" {
  count               = 2
  name                = "nic-vm-${count.index + 1}"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "example" {
  count               = 2
  name                = "vm-app-00${count.index + 1}"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_D2s_v5"
  admin_username      = "adminuser"
  admin_password      = "P@ssw0rd1234!"
  patch_mode          = "AutomaticByPlatform"

  network_interface_ids = [azurerm_network_interface.example[count.index].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-g2"
    version   = "latest"
  }

  tags = {
    Environment = "Development"
    Patching    = "Weekly"
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Maintenance Configuration
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_maintenance_configuration" "example" {
  name                     = "maint-patching-dev-001"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  scope                    = "InGuestPatch"
  in_guest_user_patch_mode = "Platform"

  window {
    start_date_time = "2024-01-07 02:00"
    duration        = "03:00"
    time_zone       = "UTC"
    recur_every     = "Week Sunday"
  }

  install_patches {
    reboot = "IfRequired"

    windows {
      classifications_to_include = ["Critical", "Security"]
    }
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Assign Maintenance to VMs
# ──────────────────────────────────────────────────────────────────────────────

module "vm_maintenance" {
  source   = "../../"
  for_each = { for vm in azurerm_windows_virtual_machine.example : vm.name => vm.id }

  location                     = azurerm_resource_group.example.location
  maintenance_configuration_id = azurerm_maintenance_configuration.example.id
  assignment_type              = "VirtualMachine"
  virtual_machine_id           = each.value
}

# ──────────────────────────────────────────────────────────────────────────────
# Dynamic Scope Assignment (Tag-based)
# ──────────────────────────────────────────────────────────────────────────────

module "dynamic_maintenance" {
  source = "../../"

  location                     = azurerm_resource_group.example.location
  maintenance_configuration_id = azurerm_maintenance_configuration.example.id
  assignment_type              = "DynamicScope"

  dynamic_scope = {
    name = "dev-weekly-patching"
    filter = {
      locations       = ["westeurope"]
      os_types        = ["Windows"]
      resource_groups = [azurerm_resource_group.example.name]
      tag_filter      = "All"
      tags = [
        {
          tag    = "Patching"
          values = ["Weekly"]
        }
      ]
    }
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Outputs
# ──────────────────────────────────────────────────────────────────────────────

output "vm_maintenance_ids" {
  description = "Maintenance assignment IDs for VMs"
  value       = { for k, v in module.vm_maintenance : k => v.id }
}

output "dynamic_scope_id" {
  description = "Dynamic scope assignment ID"
  value       = module.dynamic_maintenance.id
}
