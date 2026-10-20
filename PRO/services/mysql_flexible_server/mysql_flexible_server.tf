#############################################################################
# PROVIDER RANDOM
#############################################################################
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
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
  override_special = "!#$%&*-_=+:"
}
#############################################################################
# KEY VAULT SECRET
#############################################################################
resource "azurerm_key_vault_secret" "vm_secret" {
  name         = var.secret_name
  value        = random_password.password.result
  key_vault_id = var.keyvault_id

  tags = var.commom_tags
}
#############################################################################
# MYSQL FLEXIBLE SERVER
#############################################################################
resource "azurerm_mysql_flexible_server" "mysql" {
  name                   = var.name
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = var.administrator_login
  administrator_password = random_password.password.result
  backup_retention_days  = var.backup_retention_days
  #delegated_subnet_id    = var.delegated_subnet_id 
  #private_dns_zone_id    = var.private_dns_zone_id
  #public_network_access_enabled = true
  sku_name = var.sku_name
  zone     = var.zone
  version  = "8.0.21"

  tags = var.commom_tags

}
#############################################################################
# PRIVATE ENDPOINT
#############################################################################
resource "azurerm_private_endpoint" "private-endpoint" {

  name                = "private-endpoint-${var.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "psc-${var.name}"
    private_connection_resource_id = azurerm_mysql_flexible_server.mysql.id
    subresource_names              = ["mysqlServer"]
    is_manual_connection           = false
  }

  ip_configuration {
    name               = "ipconfig-${var.name}"
    private_ip_address = var.private_ip_address
    subresource_name   = var.subresource_name
    member_name        = var.member_name

  }
}