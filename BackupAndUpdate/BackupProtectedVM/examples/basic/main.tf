################################################################################
# Example: Complete VM Backup Setup
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
  features {
    recovery_services_vault {
      recover_soft_deleted_backup_protected_vm = true
    }
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Resource Groups
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_resource_group" "backup" {
  name     = "rg-backup-dev-001"
  location = "westeurope"
}

resource "azurerm_resource_group" "compute" {
  name     = "rg-compute-dev-001"
  location = "westeurope"
}

# ──────────────────────────────────────────────────────────────────────────────
# Networking
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_virtual_network" "example" {
  name                = "vnet-example-dev-001"
  resource_group_name = azurerm_resource_group.compute.name
  location            = azurerm_resource_group.compute.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "example" {
  name                 = "snet-vms"
  resource_group_name  = azurerm_resource_group.compute.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# ──────────────────────────────────────────────────────────────────────────────
# Sample VMs to Protect
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_network_interface" "example" {
  count               = 2
  name                = "nic-vm-${count.index + 1}"
  resource_group_name = azurerm_resource_group.compute.name
  location            = azurerm_resource_group.compute.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "example" {
  count               = 2
  name                = "vm-app-00${count.index + 1}"
  resource_group_name = azurerm_resource_group.compute.name
  location            = azurerm_resource_group.compute.location
  size                = "Standard_D2s_v5"
  admin_username      = "adminuser"
  admin_password      = "P@ssw0rd1234!"

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
}

# ──────────────────────────────────────────────────────────────────────────────
# Recovery Services Vault
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_recovery_services_vault" "example" {
  name                = "rsv-backup-dev-001"
  resource_group_name = azurerm_resource_group.backup.name
  location            = azurerm_resource_group.backup.location
  sku                 = "Standard"
  storage_mode_type   = "LocallyRedundant"
  soft_delete_enabled = true
}

# ──────────────────────────────────────────────────────────────────────────────
# Backup Policy
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_backup_policy_vm" "example" {
  name                = "bkpol-daily-dev-001"
  resource_group_name = azurerm_resource_group.backup.name
  recovery_vault_name = azurerm_recovery_services_vault.example.name

  timezone = "UTC"

  backup {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily {
    count = 14
  }

  retention_weekly {
    count    = 4
    weekdays = ["Sunday"]
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Protect VMs with Backup
# ──────────────────────────────────────────────────────────────────────────────

module "vm_backups" {
  source   = "../../"
  for_each = { for idx, vm in azurerm_windows_virtual_machine.example : vm.name => vm.id }

  resource_group_name = azurerm_resource_group.backup.name
  recovery_vault_name = azurerm_recovery_services_vault.example.name
  backup_policy_id    = azurerm_backup_policy_vm.example.id
  source_vm_id        = each.value
}

# ──────────────────────────────────────────────────────────────────────────────
# Outputs
# ──────────────────────────────────────────────────────────────────────────────

output "protected_vm_ids" {
  description = "IDs of protected VMs"
  value       = { for k, v in module.vm_backups : k => v.id }
}

output "vault_id" {
  description = "Recovery Services Vault ID"
  value       = azurerm_recovery_services_vault.example.id
}

output "policy_id" {
  description = "Backup Policy ID"
  value       = azurerm_backup_policy_vm.example.id
}
