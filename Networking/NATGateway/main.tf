################################################################################
# Public IP (Optional - for NAT Gateway)
################################################################################

resource "azurerm_public_ip" "this" {
  count = var.create && var.create_public_ip ? 1 : 0

  name                = local.pip_name
  resource_group_name = var.resource_group_name
  location            = var.location

  allocation_method = "Static"
  sku               = "Standard"
  zones             = length(var.zones) > 0 ? var.zones : ["1", "2", "3"]

  tags = local.tags
}

################################################################################
# NAT Gateway
################################################################################

# DEPENDENCY: Resource Group must exist before creating this resource
resource "azurerm_nat_gateway" "this" {
  count = var.create ? 1 : 0

  name                = local.nat_gateway_name
  resource_group_name = var.resource_group_name # DEPENDENCY: Resource Group
  location            = var.location

  sku_name                = var.sku_name
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  zones                   = var.zones

  tags = local.tags
}

################################################################################
# NAT Gateway Public IP Association
################################################################################

# DEPENDENCY: Public IP must be Standard SKU with Static allocation
resource "azurerm_nat_gateway_public_ip_association" "this" {
  for_each = var.create ? toset(local.all_public_ip_ids) : toset([])

  nat_gateway_id       = azurerm_nat_gateway.this[0].id
  public_ip_address_id = each.value # DEPENDENCY: Public IP
}

################################################################################
# NAT Gateway Public IP Prefix Association
################################################################################

# DEPENDENCY: Public IP Prefix must exist
resource "azurerm_nat_gateway_public_ip_prefix_association" "this" {
  for_each = var.create ? toset(var.public_ip_prefix_ids) : toset([])

  nat_gateway_id      = azurerm_nat_gateway.this[0].id
  public_ip_prefix_id = each.value # DEPENDENCY: Public IP Prefix
}
