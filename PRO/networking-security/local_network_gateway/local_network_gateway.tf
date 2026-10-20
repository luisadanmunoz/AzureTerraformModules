#############################################################################
# LOCAL NETWORK GATEWAY
#############################################################################
resource "azurerm_local_network_gateway" "lng" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  gateway_address     = var.gateway_address
  address_space       = var.address_space

  tags = var.tags
}
#############################################################################
# VIRTUAL NETWORK GATEWAY CONNECTION
#############################################################################
resource "azurerm_virtual_network_gateway_connection" "lngconection" {
  name                = var.name_connect
  location            = var.location
  resource_group_name = var.resource_group_name

  type                       = var.type
  virtual_network_gateway_id = var.virtual_network_gateway_id
  local_network_gateway_id   = azurerm_local_network_gateway.lng.id

  shared_key = var.shared_key

  ipsec_policy {
    dh_group         = var.dh_group
    ike_encryption   = var.ike_encryption
    ike_integrity    = var.ike_integrity
    ipsec_encryption = var.ipsec_encryption
    ipsec_integrity  = var.ipsec_integrity
    pfs_group        = var.pfs_group
    sa_datasize      = var.sa_datasize # [KB] (104857600KB = 100GB)
    sa_lifetime      = var.sa_lifetime # [Seconds] (27000s = 7.5h)
  }

}
