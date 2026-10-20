#############################################################################
# STORAGE QUEUES
#############################################################################
module "storage_queue" {
  source = "./modules/storage_queue"

  for_each = var.storage_queues

  storage_queue_name = each.value["storage_queue_name"]
  storage_account_id = try(
    element([for _, storage_account in module.storage_account : storage_account.id if storage_account.name == each.value["storage_account_name"]], 0),
    each.value["storage_account_id"],
    null
  )
  storage_account_name = try(each.value["storage_account_name"], null)
  metadata             = try(each.value["metadata"], null)
  timeouts             = try(each.value["timeouts"], null)
}
