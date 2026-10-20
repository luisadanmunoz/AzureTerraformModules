#############################################################################
# IOT HUB DEVICE UPDATE INSTANCES
#############################################################################
module "iothub_device_update_instance" {
  source = "./modules/iothub_device_update_instance"

  for_each = var.iothub_device_update_instances

  iothub_device_update_instance_name = each.value["iothub_device_update_instance_name"]
  device_update_account_id = try(
    element([for _, account in module.iothub_device_update_account : account.id if account.name == each.value["iothub_device_update_account_name"]], 0),
    each.value["device_update_account_id"]
  )
  iothub_id = try(
    element([for _, iothub in module.iothub : iothub.id if iothub.name == each.value["iothub_name"]], 0),
    each.value["iothub_id"]
  )
  diagnostic_enabled         = try(each.value["diagnostic_enabled"], null)
  diagnostic_storage_account = try(each.value["diagnostic_storage_account"], null)
  timeouts                   = try(each.value["timeouts"], null)
  tags                       = try(each.value["tags"], var.tags)
}
