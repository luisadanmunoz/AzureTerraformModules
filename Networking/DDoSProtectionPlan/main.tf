################################################################################
# DDoS Protection Plan
################################################################################

resource "azurerm_network_ddos_protection_plan" "this" {
  count = var.create ? 1 : 0

  name                = local.plan_name
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = local.tags
}
