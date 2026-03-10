################################################################################
# Dedicated Host
################################################################################

# DEPENDENCY: Resource Group must exist
# DEPENDENCY: Dedicated Host Group must exist

resource "azurerm_dedicated_host" "this" {
  count = var.create ? 1 : 0

  name                    = local.resource_name
  location                = var.location
  dedicated_host_group_id = var.dedicated_host_group_id
  sku_name                = var.sku_name
  platform_fault_domain   = var.platform_fault_domain
  auto_replace_on_failure = var.auto_replace_on_failure
  license_type            = var.license_type

  tags = local.tags
}
