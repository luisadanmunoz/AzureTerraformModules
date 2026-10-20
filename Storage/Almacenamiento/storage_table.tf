#############################################################################
# STORAGE TABLES
#############################################################################
module "storage_table" {
  source = "./modules/storage_table"

  for_each = var.storage_tables

  storage_table_name = each.value["storage_table_name"]
  storage_account_name = try(
    element([for _, storage_account in module.storage_account : storage_account.name if storage_account.name == each.value["storage_account_name"]], 0),
    each.value["storage_account_name"]
  )
  acl      = try(each.value["acl"], [])
  timeouts = try(each.value["timeouts"], null)
}
