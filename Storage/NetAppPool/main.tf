################################################################################
# NetApp Capacity Pool
################################################################################

# DEPENDENCY: Resource Group and NetApp Account must exist before creating this resource
resource "azurerm_netapp_pool" "this" {
  count = var.create ? 1 : 0

  name                = local.resource_name
  resource_group_name = var.resource_group_name # DEPENDENCY: Resource Group
  location            = var.location            # DEPENDENCY: Should align with Resource Group and NetApp Account location
  account_name        = var.account_name        # DEPENDENCY: NetApp Account must exist

  # Capacity Pool size in bytes (converting from TiB)
  size_in_tb    = var.size_in_tb
  service_level = var.service_level
  qos_type      = var.qos_type

  # Optional encryption type (Single or Double)
  encryption_type = var.encryption_type

  tags = local.tags
}
