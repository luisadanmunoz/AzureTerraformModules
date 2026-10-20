################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Shared Image Gallery."
  value       = var.create ? azurerm_shared_image_gallery.this[0].id : null
}

output "name" {
  description = "The name of the Shared Image Gallery."
  value       = var.create ? azurerm_shared_image_gallery.this[0].name : null
}

output "unique_name" {
  description = "The unique name of the Shared Image Gallery."
  value       = var.create ? azurerm_shared_image_gallery.this[0].unique_name : null
}
