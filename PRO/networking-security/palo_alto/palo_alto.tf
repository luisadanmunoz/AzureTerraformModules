# #############################################################################
# PALO ALTO KEYVAULT
# #############################################################################
//PS C:\LuisAdan\6 IaC\2 Repositorios\IAM_gitlab_client> az vm image terms accept --urn paloaltonetworks:vmseries-flex:byol:11.0.401 #REGISTRAR EL FIREWALL EN EL TENANT

data "azurerm_key_vault" "keyvault_01" {
  name                = var.keyvault_name
  resource_group_name = var.keyvault_resourcegroup_name
}
resource "azurerm_key_vault_secret" "keyvault_secret_01" {
  name         = var.keyvault_secret_name_01
  value        = random_password.pass_palo_01.result
  key_vault_id = data.azurerm_key_vault.keyvault_01.id
}
# #############################################################################
# PALO ALTO RANDOM PASSWORD
# #############################################################################
resource "random_password" "pass_palo_01" {
  length           = 16
  special          = true
  override_special = "_%@"
}
# #############################################################################
# PALO ALTO NETWORKING
# #############################################################################
data "azurerm_virtual_network" "vnet_01" {
  name                = var.vnet_name_01
  resource_group_name = var.vnet_resourcegroup_01
}
# #############################################################################
# PALO ALTO NIC MANAGEMENT
# #############################################################################
data "azurerm_subnet" "subnet_01" {
  name                 = var.subnet_name_01
  resource_group_name  = var.vnet_resourcegroup_01
  virtual_network_name = data.azurerm_virtual_network.vnet_01.name
}
resource "azurerm_network_interface" "FW1_MGMT_nic" {
  name                = var.interface_name_01
  location            = var.vm_location_01
  resource_group_name = var.vm_resourcegroup_01
  //enable_ip_forwarding          = true
  accelerated_networking_enabled = true
  ip_forwarding_enabled          = true

  ip_configuration {
    name                          = var.interface_config_name_01
    subnet_id                     = data.azurerm_subnet.subnet_01.id
    private_ip_address_allocation = var.interface_privateip_allocation_01
    private_ip_address            = var.interface_privateip_address_01
  }
  tags = var.tags
}
# #############################################################################
# PALO ALTO NIC TRUST
# #############################################################################
data "azurerm_subnet" "subnet_02" {
  name                 = var.subnet_name_02
  resource_group_name  = var.vnet_resourcegroup_01
  virtual_network_name = data.azurerm_virtual_network.vnet_01.name
}
resource "azurerm_network_interface" "FW1_TST_nic" {
  name                = var.interface_name_02
  location            = var.vm_location_01
  resource_group_name = var.vm_resourcegroup_01
  //enable_ip_forwarding          = true
  accelerated_networking_enabled = true
  ip_forwarding_enabled          = true

  ip_configuration {
    name                          = var.interface_config_name_02
    subnet_id                     = data.azurerm_subnet.subnet_02.id
    private_ip_address_allocation = var.interface_privateip_allocation_02
    //private_ip_address            = var.interface_privateip_address_02
  }
  tags = var.tags
}
# #############################################################################
# PALO ALTO NIC UNTRUST
# #############################################################################
data "azurerm_subnet" "subnet_03" {
  name                 = var.subnet_name_03
  resource_group_name  = var.vnet_resourcegroup_01
  virtual_network_name = data.azurerm_virtual_network.vnet_01.name
}
resource "azurerm_network_interface" "FW1_UNT_nic" {
  name                = var.interface_name_03
  location            = var.vm_location_01
  resource_group_name = var.vm_resourcegroup_01
  //enable_ip_forwarding          = true
  accelerated_networking_enabled = true
  ip_forwarding_enabled          = true


  ip_configuration {
    name                          = var.interface_config_name_03
    subnet_id                     = data.azurerm_subnet.subnet_03.id
    private_ip_address_allocation = var.interface_privateip_allocation_03
    //private_ip_address            = var.interface_privateip_address_03
  }
  tags = var.tags
}
# #############################################################################
# PALO ALTO VIRTUAL MACHINE
# #############################################################################

resource "azurerm_virtual_machine" "VM_FW1" {
  name                         = var.vm_name_01
  location                     = var.vm_location_01
  resource_group_name          = var.vm_resourcegroup_01
  network_interface_ids        = ["${azurerm_network_interface.FW1_UNT_nic.id}", "${azurerm_network_interface.FW1_TST_nic.id}", "${azurerm_network_interface.FW1_MGMT_nic.id}"]
  vm_size                      = var.vm_size_01
  zones                        = [var.zones]
  primary_network_interface_id = azurerm_network_interface.FW1_MGMT_nic.id

  storage_os_disk {
    name              = var.vm_osdisk_name_01
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    disk_size_gb      = "60"
  }

  storage_image_reference {
    publisher = var.vm_image_publisher_01
    offer     = var.vm_image_offer_01
    sku       = var.vm_image_sku_01
    version   = var.vm_image_version_01
  }

  os_profile {
    computer_name  = var.vm_name_01
    admin_username = "UserAdminIAM$"
    admin_password = azurerm_key_vault_secret.keyvault_secret_01.value
  }

  # boot_diagnostics {
  #   enabled     = "true"
  #   storage_uri = "${var.boot_diags_sa_uri}"
  # }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  plan {
    name      = "byol"
    publisher = "paloaltonetworks"
    product   = "vmseries-flex" //"vmseries1"
  }

  tags = var.tags
}