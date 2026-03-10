################################################################################
# AVD Workspace
################################################################################

resource "azurerm_virtual_desktop_workspace" "this" {
  count = var.create ? 1 : 0

  name                = local.resource_name
  resource_group_name = var.resource_group_name
  location            = var.location

  # Workspace Configuration
  friendly_name                 = var.friendly_name
  description                   = var.description
  public_network_access_enabled = var.public_network_access_enabled

  tags = local.tags
}

################################################################################
# Application Group Association
################################################################################

resource "azurerm_virtual_desktop_workspace_application_group_association" "this" {
  for_each = var.create ? toset(var.application_group_ids) : toset([])

  workspace_id         = azurerm_virtual_desktop_workspace.this[0].id
  application_group_id = each.value
}
