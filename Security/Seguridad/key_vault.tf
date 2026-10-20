#############################################################################
# KEY VAULTS
#############################################################################
module "key_vault" {
  source = "./modules/key_vault"

  for_each = var.key_vaults

  key_vault_name = each.value["key_vault_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location                        = each.value["location"]
  tenant_id                       = each.value["tenant_id"]
  sku_name                        = each.value["sku_name"]
  enabled_for_deployment          = try(each.value["enabled_for_deployment"], null)
  enabled_for_disk_encryption     = try(each.value["enabled_for_disk_encryption"], null)
  enabled_for_template_deployment = try(each.value["enabled_for_template_deployment"], null)
  public_network_access_enabled   = try(each.value["public_network_access_enabled"], null)
  purge_protection_enabled        = try(each.value["purge_protection_enabled"], null)
  rbac_authorization_enabled      = try(each.value["rbac_authorization_enabled"], null)
  soft_delete_retention_days      = try(each.value["soft_delete_retention_days"], null)
  network_acls                    = try(each.value["network_acls"], null)
  access_policies                 = coalesce(try(each.value["access_policies"], null), [])
  timeouts                        = try(each.value["timeouts"], null)
  tags                            = try(each.value["tags"], var.tags)
}
