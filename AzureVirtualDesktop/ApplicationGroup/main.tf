################################################################################
# AVD Application Group
################################################################################

resource "azurerm_virtual_desktop_application_group" "this" {
  count = var.create ? 1 : 0

  name                = local.resource_name
  resource_group_name = var.resource_group_name
  location            = var.location

  # Application Group Configuration
  host_pool_id = var.host_pool_id
  type         = var.type

  friendly_name                = var.friendly_name
  description                  = var.description
  default_desktop_display_name = local.is_desktop ? var.default_desktop_display_name : null

  tags = local.tags
}
