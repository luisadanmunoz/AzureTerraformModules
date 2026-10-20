################################################################################
# Azure Portal Dashboard
################################################################################

resource "azurerm_portal_dashboard" "this" {
  count = var.create ? 1 : 0

  name                 = var.name
  resource_group_name  = var.resource_group_name
  location             = var.location
  dashboard_properties = var.dashboard_properties

  tags = local.tags
}
