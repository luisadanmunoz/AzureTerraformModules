################################################################################
# Gallery Image Definition
################################################################################

# DEPENDENCY: Resource Group must exist
# DEPENDENCY: Shared Image Gallery must exist

resource "azurerm_shared_image" "this" {
  count = var.create ? 1 : 0

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  gallery_name        = var.gallery_name

  os_type            = var.os_type
  hyper_v_generation = var.hyper_v_generation
  architecture       = var.architecture
  specialized        = var.specialized

  identifier {
    publisher = var.identifier.publisher
    offer     = var.identifier.offer
    sku       = var.identifier.sku
  }

  description           = var.description
  eula                  = var.eula
  privacy_statement_uri = var.privacy_statement_uri
  release_note_uri      = var.release_note_uri

  trusted_launch_enabled              = var.trusted_launch_enabled
  accelerated_network_support_enabled = var.accelerated_network_support_enabled
  confidential_vm_enabled             = var.confidential_vm_enabled
  confidential_vm_supported           = var.confidential_vm_supported

  min_recommended_vcpu_count   = var.min_recommended_vcpu_count
  max_recommended_vcpu_count   = var.max_recommended_vcpu_count
  min_recommended_memory_in_gb = var.min_recommended_memory_in_gb
  max_recommended_memory_in_gb = var.max_recommended_memory_in_gb

  tags = local.tags
}
