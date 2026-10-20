#############################################################################
# KEY VAULT
#############################################################################
resource "azurerm_key_vault" "key_vault" {
  name                            = var.key_vault_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  tenant_id                       = var.tenant_id
  sku_name                        = var.sku_name
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  public_network_access_enabled   = var.public_network_access_enabled
  purge_protection_enabled        = var.purge_protection_enabled
  rbac_authorization_enabled      = var.rbac_authorization_enabled
  soft_delete_retention_days      = var.soft_delete_retention_days
  tags                            = var.tags

  dynamic "network_acls" {
    for_each = var.network_acls != null ? [var.network_acls] : []

    content {
      bypass                     = network_acls.value["bypass"]
      default_action             = network_acls.value["default_action"]
      ip_rules                   = try(network_acls.value["ip_rules"], null)
      virtual_network_subnet_ids = try(network_acls.value["virtual_network_subnet_ids"], null)
    }
  }

  dynamic "access_policy" {
    for_each = var.access_policies

    content {
      tenant_id               = access_policy.value["tenant_id"]
      object_id               = access_policy.value["object_id"]
      application_id          = try(access_policy.value["application_id"], null)
      key_permissions         = try(access_policy.value["key_permissions"], null)
      secret_permissions      = try(access_policy.value["secret_permissions"], null)
      certificate_permissions = try(access_policy.value["certificate_permissions"], null)
      storage_permissions     = try(access_policy.value["storage_permissions"], null)
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      update = try(timeouts.value["update"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }
}
