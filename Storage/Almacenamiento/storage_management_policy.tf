#############################################################################
# STORAGE MANAGEMENT POLICIES
#############################################################################
module "storage_management_policy" {
  source = "./modules/storage_management_policy"

  for_each = var.storage_management_policies

  storage_account_id = try(
    element([for _, storage_account in module.storage_account : storage_account.id if storage_account.name == each.value["storage_account_name"]], 0),
    each.value["storage_account_id"]
  )
  rules    = each.value["rules"]
  timeouts = try(each.value["timeouts"], null)
}
