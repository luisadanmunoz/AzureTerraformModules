/*
#############################################################################
# PROVIDER RANDOM
#############################################################################
terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.1.3"
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
# KEY VAULT SECRET - KEY SSH PRIVATE
#############################################################################
resource "azurerm_key_vault_secret" "vm_secret" {
  name         = "vm-eu-west-pro-bigip-01-keysshprivate"//"${var.name}-keysshprivate" //"f5keysshprivate"
  value        = tls_private_key.tls_private_key.private_key_openssh
  key_vault_id = var.keyvault_id
  
  //content_type = "f5keysshprivate" //"${var.name}-keysshprivate"
  //expiration_date = "2028-12-31T00:00:00Z"
  
}
#############################################################################
# KEY VAULT SECRET - PASSWORD HTTPS PORTAL F5 BIG-IP
#############################################################################
resource "azurerm_key_vault_secret" "credential_vm_secret" {
  name         = "vm-eu-west-pro-bigip-01-keyhttpsprivate" //"${var.name}-keyhttpsprivate" //"f5keyhttpsprivate"
  value        = random_password.password.result 
  key_vault_id = var.keyvault_id
  //content_type = "f5keyhttpsprivate" //"${var.name}-keyhttpsprivate"
  //expiration_date = "2028-12-31T00:00:00Z"
}
*/
#############################################################################
# TLS PRIVATE KEY
#############################################################################
resource "tls_private_key" "tls_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
#############################################################################
# LINUX VIRTUAL MACHINE - F5 BIGIP
#############################################################################
resource "azurerm_linux_virtual_machine" "bigip" {
  name                            = var.name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.size
  admin_username                  = "bigipuser"
  admin_password                  = "YourP@ssword78689gfts7" //random_password.password.result //
  disable_password_authentication = false
  zone                            = var.zone

  custom_data = base64encode(coalesce(null, templatefile("${path.module}/templates/f5_onboard.tmpl",
    {
      INIT_URL                   = var.INIT_URL
      DO_URL                     = var.DO_URL
      AS3_URL                    = var.AS3_URL
      TS_URL                     = var.TS_URL
      CFE_URL                    = var.CFE_URL
      FAST_URL                   = var.FAST_URL,
      DO_VER                     = format("v%s", split("-", split("/", var.DO_URL)[length(split("/", var.DO_URL)) - 1])[3])
      AS3_VER                    = format("v%s", split("-", split("/", var.AS3_URL)[length(split("/", var.AS3_URL)) - 1])[2])
      TS_VER                     = format("v%s", split("-", split("/", var.TS_URL)[length(split("/", var.TS_URL)) - 1])[2])
      CFE_VER                    = format("v%s", split("-", split("/", var.CFE_URL)[length(split("/", var.CFE_URL)) - 1])[3])
      FAST_VER                   = format("v%s", split("-", split("/", var.FAST_URL)[length(split("/", var.FAST_URL)) - 1])[3])
      vault_url                  = ""
      secret_id                  = ""
      az_keyvault_authentication = false
      bigip_username             = "bigipuser"
      ssh_keypair                = tls_private_key.tls_private_key.public_key_openssh
      bigip_password             = "YourP@ssworh7774845gtgs7" //random_password.password.result
  })))

  network_interface_ids = [
    azurerm_network_interface.mgmt_nic.id,
    azurerm_network_interface.public_nic.id,
    azurerm_network_interface.private_nic.id,
  ]

  admin_ssh_key {
    username   = "bigipuser"
    public_key = tls_private_key.tls_private_key.public_key_openssh //file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "f5-networks"
    offer     = "f5-big-ip-byol"
    sku       = "f5-big-all-2slot-byol"
    version   = "15.1.1004000"
  }

  plan {
    publisher = "f5-networks"
    product   = "f5-big-ip-byol"
    name      = "f5-big-all-2slot-byol"
  }

  identity {
    identity_ids = [azurerm_user_assigned_identity.identity.id]
    type         = "UserAssigned"
  }
  /*
  lifecycle {
  ignore_changes = [
    custom_data
  ]
}
*/

}
#############################################################################
# NETWROK INTERFACE private - LINUX VIRTUAL MACHINE - F5 BIGIP
############################################################################# 
resource "azurerm_network_interface" "private_nic" {
  name                = "${var.name}-private"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.name}-private"
    subnet_id                     = var.subnet_private_id
    private_ip_address            = var.ip_private
    private_ip_address_allocation = "Static"
    //public_ip_address_id          = var.public_ip_address_id
  }

}
#############################################################################
# NETWROK INTERFACE MANAGEMENT - LINUX VIRTUAL MACHINE - F5 BIGIP
############################################################################# 
resource "azurerm_network_interface" "mgmt_nic" {
  name                = "${var.name}-mgmt"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.name}-mgmt"
    subnet_id                     = var.subnet_mgmt_id
    private_ip_address            = var.ip_management
    private_ip_address_allocation = "Static"
    //public_ip_address_id          = var.public_ip_address_id
  }
}
#############################################################################
# NETWROK INTERFACE public - LINUX VIRTUAL MACHINE - F5 BIGIP
############################################################################# 
resource "azurerm_network_interface" "public_nic" {
  name                = "${var.name}-public"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.name}-public"
    subnet_id                     = var.subnet_public_id
    private_ip_address            = var.ip_public
    private_ip_address_allocation = "Static"
    primary                       = true
    //public_ip_address_id          = var.public_ip_address_id
  }
  ip_configuration {
    name                          = "${var.name}-public-02"
    subnet_id                     = var.subnet_public_id_2
    private_ip_address            = var.ip_public_2
    private_ip_address_allocation = "Static"
    primary                       = false
    //public_ip_address_id          = var.public_ip_address_id
  }

}
#############################################################################
# VIRTUAL MACHINE EXTENSION
#############################################################################
resource "azurerm_virtual_machine_extension" "vmext" {
  failure_suppression_enabled = false
  name                        = azurerm_linux_virtual_machine.bigip.name
  publisher                   = "Microsoft.Azure.Extensions"
  settings                    = <<-EOT
            {
                  "commandToExecute": "bash /var/lib/waagent/CustomData; exit 0;"
                }
        EOT

  type                 = "CustomScript"
  type_handler_version = "2.0"
  virtual_machine_id   = azurerm_linux_virtual_machine.bigip.id

}
#############################################################################
# USER ASSIGNED IDENTITY
#############################################################################
resource "azurerm_user_assigned_identity" "identity" {
  location            = var.location
  name                = "${var.name}-identityF5BigIP"
  resource_group_name = var.resource_group_name
}
#############################################################################
# SSH PUBLIC KEY
#############################################################################
resource "azurerm_ssh_public_key" "f5_key" {
  name                = "${var.name}-ssh-key"
  resource_group_name = var.resource_group_name
  location            = var.location
  public_key          = tls_private_key.tls_private_key.public_key_openssh //file("~/.ssh/id_rsa.pub")
}