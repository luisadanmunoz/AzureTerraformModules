################################################################################
# Local Values
################################################################################

locals {
  # Note: azuread_application uses a set of string tags, not a map like azurerm resources.
  # Tags are managed directly via the var.tags variable.
  module_name = "Application"
}
