#############################################################################
# AZURE FIREWALL
#############################################################################
resource "azurerm_firewall" "firewall" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  firewall_policy_id  = azurerm_firewall_policy.firewall_policy.id

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.subnet_id
    public_ip_address_id = var.public_ip_address_id
  }
  tags = var.tags

  management_ip_configuration {
    name                 = var.management_name
    subnet_id            = var.subnet_management_id
    public_ip_address_id = var.management_public_ip_address_id

  }

}
#############################################################################
# AZURE FIREWALL POLICY
#############################################################################
resource "azurerm_firewall_policy" "firewall_policy" {
  name                = var.name_firewall_policy
  resource_group_name = azurerm_firewall.firewall.resource_group_name
  location            = azurerm_firewall.firewall.location

  tags = var.tags
}