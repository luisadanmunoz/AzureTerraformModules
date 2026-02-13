################################################################################
# Shared Image Gallery
################################################################################

# DEPENDENCY: Resource Group must exist

resource "azurerm_shared_image_gallery" "this" {
  count = var.create ? 1 : 0

  name                = local.resource_name
  resource_group_name = var.resource_group_name
  location            = var.location
  description         = var.description

  dynamic "sharing" {
    for_each = var.sharing.permission != "Private" ? [var.sharing] : []
    content {
      permission = sharing.value.permission

      dynamic "community_gallery" {
        for_each = sharing.value.community_gallery != null ? [sharing.value.community_gallery] : []
        content {
          eula            = community_gallery.value.eula
          prefix          = community_gallery.value.prefix
          publisher_email = community_gallery.value.publisher_email
          publisher_uri   = community_gallery.value.publisher_uri
        }
      }
    }
  }

  tags = local.tags
}
