#############################################################################
# STORAGE DATA LAKE GEN2 FILESYSTEMS
#############################################################################
module "storage_data_lake_gen2_filesystem" {
  source = "./modules/storage_data_lake_gen2_filesystem"

  for_each = var.storage_data_lake_gen2_filesystems

  storage_data_lake_gen2_filesystem_name = each.value["storage_data_lake_gen2_filesystem_name"]
  storage_account_id = try(
    element([for _, storage_account in module.storage_account : storage_account.id if storage_account.name == each.value["storage_account_name"]], 0),
    each.value["storage_account_id"]
  )
  default_encryption_scope = try(each.value["default_encryption_scope"], null)
  properties               = try(each.value["properties"], null)
  ace                      = try(each.value["ace"], [])
  timeouts                 = try(each.value["timeouts"], null)
}
