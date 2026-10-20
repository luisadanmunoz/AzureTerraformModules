#############################################################################
# LINUX VIRTUAL MACHINE MODULE - FORTINET FORTIGATE
#############################################################################

terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.1.3"
    }
  }
}

resource "random_password" "password" {
  length           = 16
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_key_vault_secret" "vm_secret" {
  name         = var.secret_name
  value        = random_password.password.result
  key_vault_id = var.keyvault_id

  tags = var.tags
}
################################################################# NIC HA
resource "azurerm_network_interface" "ha" {
  name                 = "${var.vm_name}-ha"
  location             = var.location
  resource_group_name  = var.resource_group_name
  enable_ip_forwarding = true
  tags                 = var.tags

  ip_configuration {
    name                          = "ha"
    subnet_id                     = var.subnet_id_ha
    private_ip_address_allocation = var.private_ip_address_allocation_ha
    private_ip_address            = (var.private_ip_address_allocation_ha == "Static" ? var.private_ip_address_ha : null)
    //public_ip_address_id = var.public_ip_address_id
  }
}
################################################################# NIC PUBLIC
resource "azurerm_network_interface" "public" {
  name                 = "${var.vm_name}-public"
  location             = var.location
  resource_group_name  = var.resource_group_name
  enable_ip_forwarding = true

  tags = var.tags

  ip_configuration {
    name                          = "public"
    subnet_id                     = var.subnet_id_public
    private_ip_address_allocation = var.private_ip_address_allocation_public
    private_ip_address            = (var.private_ip_address_allocation_public == "Static" ? var.private_ip_address_public : null)
    //public_ip_address_id = var.public_ip_address_id
  }

  dynamic "ip_configuration" {
    for_each = var.floating-public == true ? [1] : []
    content {
      name                          = "floating-public"
      subnet_id                     = var.subnet_id_public
      private_ip_address_allocation = var.private_ip_address_allocation_public
      private_ip_address            = (var.private_ip_address_allocation_public == "Static" ? var.private_ip_address_public_floating-public : null)
      //public_ip_address_id = var.public_ip_address_id

    }
  }

}

################################################################# NIC MGMT
resource "azurerm_network_interface" "mgmt" {
  name                 = "${var.vm_name}-mgmt"
  location             = var.location
  resource_group_name  = var.resource_group_name
  enable_ip_forwarding = true

  tags = var.tags

  ip_configuration {
    name                          = "mgmt"
    subnet_id                     = var.subnet_id_mgmt
    private_ip_address_allocation = var.private_ip_address_allocation_mgmt
    private_ip_address            = (var.private_ip_address_allocation_mgmt == "Static" ? var.private_ip_address_mgmt : null)
    public_ip_address_id          = var.public_ip_address_id
  }
}
################################################################# NIC privada
resource "azurerm_network_interface" "private" {
  name                 = "${var.vm_name}-private"
  location             = var.location
  resource_group_name  = var.resource_group_name
  enable_ip_forwarding = true

  tags = var.tags

  ip_configuration {
    name                          = "private"
    subnet_id                     = var.subnet_id_private
    private_ip_address_allocation = var.private_ip_address_allocation_private
    private_ip_address            = (var.private_ip_address_allocation_private == "Static" ? var.private_ip_address_private : null)
    //public_ip_address_id = var.public_ip_address_id
  }


  dynamic "ip_configuration" {
    for_each = var.floating-private == true ? [1] : []
    content {
      name                          = "floating-private"
      subnet_id                     = var.subnet_id_private
      private_ip_address_allocation = var.private_ip_address_allocation_private
      private_ip_address            = (var.private_ip_address_allocation_private == "Static" ? var.private_ip_address_private_floating-private : null)
      //public_ip_address_id = var.public_ip_address_id
    }
  }

}



resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                            = var.vm_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.size //"Standard_F4"
  disable_password_authentication = false
  admin_username                  = var.admin_username
  admin_password                  = random_password.password.result
  allow_extension_operations      = true           # AÑADIDO
  computer_name                   = "activefgt"    #ANADIDO
  encryption_at_host_enabled      = false          #ANADIDO
  extensions_time_budget          = "PT1H30M"      #ANADIDO
  max_bid_price                   = -1             #ANADIDO
  patch_assessment_mode           = "ImageDefault" #ANADIDO
  patch_mode                      = "ImageDefault" #ANADIDO
  //platform_fault_domain           = -1 #ANADIDO
  priority            = "Regular" #ANADIDO
  provision_vm_agent  = true      #ANADIDO
  secure_boot_enabled = false     #ANADIDO
  vtpm_enabled        = false     #ANADIDO


  boot_diagnostics {                                                           #ANADIDO
    storage_account_uri = "https://steuweterraformerpro.blob.core.windows.net" //"https://diag8b6554d507bbb0dc.blob.core.windows.net/"
  }

  network_interface_ids = [
    //azurerm_network_interface.public.id,azurerm_network_interface.ha.id,azurerm_network_interface.private.id,azurerm_network_interface.mgmt.id
    azurerm_network_interface.mgmt.id, azurerm_network_interface.public.id, azurerm_network_interface.private.id, azurerm_network_interface.ha.id
  ]
  os_disk {
    caching                   = "ReadWrite"
    storage_account_type      = "Standard_LRS"
    disk_size_gb              = 2           #AÑADIDO
    name                      = var.os_disk #ANADIDO
    write_accelerator_enabled = false
  }

  plan { #AÑADIDO
    name      = "fortinet_fg-vm_payg_2023"
    product   = "fortinet_fortigate-vm_v5"
    publisher = "fortinet"
  }

  source_image_reference {
    publisher = var.publisher  #"fortinet_fortigate-vm_v5"
    offer     = var.offer      #"fortinet"
    sku       = var.sku        #"fortinet_fg-vm_payg_2023"
    version   = var.os_version #"7.2.8" confirmar con correo
  }

  tags = var.tags

}
