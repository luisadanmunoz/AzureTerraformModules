#############################################################################
# PROVIDER RANDOM
#############################################################################
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0"
    }
  }
}
#############################################################################
# RANDOM PASSWORD
#############################################################################
resource "random_password" "password" {
  length           = 16
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
#############################################################################
# KEY VAULT SECRET
#############################################################################
resource "azurerm_key_vault_secret" "vm_secret" {
  name         = "${var.vm_name}-pass"
  value        = random_password.password.result
  key_vault_id = var.keyvault_id
  content_type = "${var.vm_name}-pass"
  //expiration_date  = "2029-03-31T00:00:00Z"
  tags = var.tags
}
#############################################################################
# WINDOWS VIRTUAL MACHINE
#############################################################################
resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.vm_name
  computer_name       = var.computer_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  admin_username      = var.admin_username
  admin_password      = random_password.password.result
  zone                = var.zone
  license_type        = var.license_type

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    name                 = "osdisk-${var.vm_name}"
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type

  }
  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.os_version
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags

  depends_on = [
    azurerm_network_interface.nic
  ]
}
#############################################################################
# WINDOWS VIRTUAL MACHINE MODULE - NETWORK INTERFACE
#############################################################################

resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic-MGMT"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    private_ip_address            = (var.private_ip_address_allocation == "Static" ? var.private_ip_address : null)
    #public_ip_address_id = var.public_ip_address_id
  }
}
/*
#############################################################################
# WINDOWS VIRTUAL MACHINE MODULE - MANAGED DISK
#############################################################################
resource "azurerm_managed_disk" "data_disk" {
  name                 = "${azurerm_windows_virtual_machine.vm.name}-disk1"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.storage_account_type
  create_option        = var.create_option
  disk_size_gb         = var.disk_size_gb
  tier                 = var.tier
  
public_network_access_enabled = true
}
#############################################################################
# WINDOWS VIRTUAL MACHINE MODULE - DATA DISK ATTACHMENT
#############################################################################
resource "azurerm_virtual_machine_data_disk_attachment" "attach_disk_vm" {
  managed_disk_id    = azurerm_managed_disk.data_disk.id
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id
  lun                = var.lun
  caching            = var.caching
}
#############################################################################
# WINDOWS VIRTUAL MACHINE BACKUP PROTECTED
#############################################################################
resource "azurerm_backup_protected_vm" "vm" {
  resource_group_name = var.resource_group_name
  recovery_vault_name = var.recovery_vault_name
  source_vm_id        = azurerm_windows_virtual_machine.vm.id
  backup_policy_id    = var.backup_policy_id
}

#############################################################################
# DIAGNOSTIC SETTINGS
#############################################################################
data "azurerm_monitor_diagnostic_categories" "diagnostic_setting" {
  resource_id = azurerm_network_interface.nic.id
}
resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  name               = var.name_diagnostic_setting
  target_resource_id = azurerm_network_interface.nic.id
  log_analytics_workspace_id = var.workspace_resource_id
  
  dynamic "enabled_log" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.diagnostic_setting.log_category_types
    content {
      category = entry.value
      #enabled  = true
    }
  }
  dynamic "metric" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.diagnostic_setting.metrics 
    content {
      category = entry.value
      enabled  = true
    }
  }

  lifecycle {
    ignore_changes = [ enabled_log, metric ]
  }
}
*/