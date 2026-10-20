#############################################################################
# STORAGE SHARES
#############################################################################
module "storage_share" {
  source = "./modules/storage_share"

  for_each = var.storage_shares

  storage_share_name = each.value["storage_share_name"]
  storage_account_id = try(
    element([for _, storage_account in module.storage_account : storage_account.id if storage_account.name == each.value["storage_account_name"]], 0),
    each.value["storage_account_id"],
    null
  )
  storage_account_name = try(each.value["storage_account_name"], null)
  quota                = each.value["quota"]
  access_tier          = try(each.value["access_tier"], null)
  enabled_protocol     = try(each.value["enabled_protocol"], null)
  metadata             = try(each.value["metadata"], null)
  acl                  = try(each.value["acl"], [])
  timeouts             = try(each.value["timeouts"], null)
}
