#############################################################################
# BASTION HOST
#############################################################################
resource "azurerm_bastion_host" "bastion_host" {
  name                   = var.bastion_host_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  sku                    = var.sku
  scale_units            = var.scale_units
  copy_paste_enabled     = var.copy_paste_enabled
  file_copy_enabled      = var.file_copy_enabled
  ip_connect_enabled     = var.ip_connect_enabled
  shareable_link_enabled = var.shareable_link_enabled
  tunneling_enabled      = var.tunneling_enabled
  zones                  = var.zones
  tags                   = var.tags

  ip_configuration {
    name                 = "${var.bastion_host_name}-ipconfig"
    subnet_id            = var.subnet_id
    public_ip_address_id = var.public_ip_id
  }
}
