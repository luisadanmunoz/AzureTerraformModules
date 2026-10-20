#############################################################################
# RESOURCE PROVIDER REGISTRATION
#############################################################################
resource "azurerm_resource_provider_registration" "resource_provider_registration" {
  name = var.resource_provider_name
}
