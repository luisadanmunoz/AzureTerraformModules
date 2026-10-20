#############################################################################
# COGNITIVE ACCOUNT CUSTOMER MANAGED KEYS
#############################################################################
module "cognitive_account_customer_managed_key" {
  source = "./modules/cognitive_account_customer_managed_key"

  for_each = var.cognitive_account_customer_managed_keys

  cognitive_account_id = try(
    element([for _, cognitive_account in module.cognitive_account : cognitive_account.id if cognitive_account.name == each.value["cognitive_account_name"]], 0),
    each.value["cognitive_account_id"]
  )
  key_vault_key_id   = each.value["key_vault_key_id"]
  identity_client_id = try(each.value["identity_client_id"], null)
  timeouts           = try(each.value["timeouts"], null)
}
