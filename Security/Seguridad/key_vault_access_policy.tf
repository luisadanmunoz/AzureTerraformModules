#############################################################################
# KEY VAULT ACCESS POLICIES
#############################################################################
module "key_vault_access_policy" {
  source = "./modules/key_vault_access_policy"

  for_each = var.key_vault_access_policies

  key_vault_id = try(
    element([for _, key_vault in module.key_vault : key_vault.id if key_vault.name == each.value["key_vault_name"]], 0),
    each.value["key_vault_id"]
  )
  tenant_id               = each.value["tenant_id"]
  object_id               = each.value["object_id"]
  application_id          = try(each.value["application_id"], null)
  certificate_permissions = try(each.value["certificate_permissions"], null)
  key_permissions         = try(each.value["key_permissions"], null)
  secret_permissions      = try(each.value["secret_permissions"], null)
  storage_permissions     = try(each.value["storage_permissions"], null)
  timeouts                = try(each.value["timeouts"], null)
}
