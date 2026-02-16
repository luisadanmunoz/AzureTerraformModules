################################################################################
# Azure AI Search Service
################################################################################

resource "azurerm_search_service" "this" {
  count = var.create ? 1 : 0

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku

  replica_count   = var.replica_count
  partition_count = var.partition_count

  public_network_access_enabled            = var.public_network_access_enabled
  local_authentication_enabled             = var.local_authentication_enabled
  authentication_failure_mode              = var.authentication_failure_mode
  customer_managed_key_enforcement_enabled = var.customer_managed_key_enforcement_enabled
  hosting_mode                             = var.hosting_mode
  semantic_search_sku                      = var.semantic_search_sku
  allowed_ips                              = var.allowed_ips

  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []
    content {
      type = var.identity_type
    }
  }

  tags = local.tags
}
