#############################################################################
# SSH PUBLIC KEY
#############################################################################
resource "azurerm_ssh_public_key" "ssh_public_key" {
  name                = var.ssh_public_key_name
  resource_group_name = var.resource_group_name
  location            = var.location
  public_key          = var.public_key
  tags                = var.tags

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      update = try(timeouts.value["update"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }
}
