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
# LINUX VIRTUAL MACHINE MODULE - NETWORK INTERFACE
#############################################################################
resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    private_ip_address            = (var.private_ip_address_allocation == "Static" ? var.private_ip_address : null)
    #public_ip_address_id = var.public_ip_address_id
  }
}
#############################################################################
# LINUX VIRTUAL MACHINE MODULE
#############################################################################
resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                            = var.vm_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.size
  disable_password_authentication = false
  admin_username                  = var.admin_username
  admin_password                  = random_password.password.result
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  /*
  admin_ssh_key {
    username   = var.admin_username
    public_key = file("~/.ssh/id_rsa.pub")
  }
*/

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.os_version
  }

  tags = var.tags

}
