################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Gallery Image Definition."
  value       = var.create ? azurerm_shared_image.this[0].id : null
}

output "name" {
  description = "The name of the Gallery Image Definition."
  value       = var.create ? azurerm_shared_image.this[0].name : null
}

output "gallery_name" {
  description = "The name of the parent Gallery."
  value       = var.gallery_name
}

output "identifier" {
  description = "The image identifier."
  value       = var.identifier
}
