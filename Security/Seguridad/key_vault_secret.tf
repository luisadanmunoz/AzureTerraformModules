#############################################################################
# KEY VAULT SECRETS
#############################################################################
module "key_vault_secret" {
  source = "./modules/key_vault_secret"

  for_each = var.key_vault_secrets

  key_vault_secret_name = each.value["key_vault_secret_name"]
  key_vault_id = try(
    element([for _, key_vault in module.key_vault : key_vault.id if key_vault.name == each.value["key_vault_name"]], 0),
    each.value["key_vault_id"]
  )
  value            = try(each.value["value"], null)
  value_wo         = try(each.value["value_wo"], null)
  value_wo_version = try(each.value["value_wo_version"], null)
  content_type     = try(each.value["content_type"], null)
  not_before_date  = try(each.value["not_before_date"], null)
  expiration_date  = try(each.value["expiration_date"], null)
  timeouts         = try(each.value["timeouts"], null)
  tags             = try(each.value["tags"], var.tags)
}
