#############################################################################
# AZURE NETAPP FILES
#############################################################################
resource "azurerm_netapp_account" "netapp_account" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.commom_tags

}

resource "azurerm_netapp_pool" "netapp_pool" {
  name                = var.netapp_pool
  location            = var.location
  resource_group_name = var.resource_group_name
  account_name        = azurerm_netapp_account.netapp_account.name
  service_level       = var.service_level
  size_in_tb          = var.size_in_tb

  tags = var.commom_tags

}

/*

resource "azurerm_netapp_volume" "netapp_volume" {
  name                       = var.netapp_volume
  location                   = var.location
  zone                       = var.zone
  resource_group_name        = var.resource_group_name
  account_name               = azurerm_netapp_account.netapp_account.name
  pool_name                  = azurerm_netapp_pool.netapp_pool.name
  volume_path                = var.volume_path
  service_level              = var.service_level
  subnet_id                  = var.subnet_id
  network_features           = var.network_features
  protocols                  = var.protocols
  security_style             = var.security_style
  storage_quota_in_gb        = var.storage_quota_in_gb
  snapshot_directory_visible = var.snapshot_directory_visible
   
}



resource "azurerm_netapp_volume_quota_rule" "quota1" {
  name              = var.name_quota_rule
  location          = var.location
  volume_id         = azurerm_netapp_volume.netapp_volume.id
  quota_target      = var.quota_target
  quota_size_in_kib = var.quota_size_in_kib
  quota_type        = var.quota_type
}




│ Error: Invalid resource type
│
│   on modules\netapp\netapp.tf line 34, in resource "azurerm_netapp_volume_quota_rule" "quota1":
│   34: resource "azurerm_netapp_volume_quota_rule" "quota1" {
│
│ The provider hashicorp/azurerm does not support resource type "azurerm_netapp_volume_quota_rule".


resource "azurerm_netapp_snapshot_policy" "snapshot_policy" {
  name                = var.snapshot_policy
  location            = var.location
  resource_group_name = var.resource_group_name
  account_name        = azurerm_netapp_account.netapp_account.name
  enabled             = false

}

*/

