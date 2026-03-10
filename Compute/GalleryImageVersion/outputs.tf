################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Gallery Image Version."
  value       = var.create ? azurerm_shared_image_version.this[0].id : null
}

output "name" {
  description = "The version name."
  value       = var.create ? azurerm_shared_image_version.this[0].name : null
}

output "gallery_name" {
  description = "The name of the parent Gallery."
  value       = var.gallery_name
}

output "image_name" {
  description = "The name of the parent Image Definition."
  value       = var.image_name
}

output "target_regions" {
  description = "The configured target regions."
  value       = var.target_regions
}
