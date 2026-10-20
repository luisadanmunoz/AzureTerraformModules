#############################################################################
# KEY VAULT KEYS
#############################################################################
module "key_vault_key" {
  source = "./modules/key_vault_key"

  for_each = var.key_vault_keys

  key_vault_key_name = each.value["key_vault_key_name"]
  key_vault_id = try(
    element([for _, key_vault in module.key_vault : key_vault.id if key_vault.name == each.value["key_vault_name"]], 0),
    each.value["key_vault_id"]
  )
  key_type        = each.value["key_type"]
  key_size        = try(each.value["key_size"], null)
  curve           = try(each.value["curve"], null)
  key_opts        = each.value["key_opts"]
  not_before_date = try(each.value["not_before_date"], null)
  expiration_date = try(each.value["expiration_date"], null)
  rotation_policy = try(each.value["rotation_policy"], null)
  timeouts        = try(each.value["timeouts"], null)
  tags            = try(each.value["tags"], var.tags)
}
