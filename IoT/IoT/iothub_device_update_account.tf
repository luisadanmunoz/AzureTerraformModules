#############################################################################
# IOT HUB DEVICE UPDATE ACCOUNTS
#############################################################################
module "iothub_device_update_account" {
  source = "./modules/iothub_device_update_account"

  for_each = var.iothub_device_update_accounts

  iothub_device_update_account_name = each.value["iothub_device_update_account_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location                      = each.value["location"]
  public_network_access_enabled = try(each.value["public_network_access_enabled"], null)
  sku                           = try(each.value["sku"], null)
  identity                      = try(each.value["identity"], null)
  timeouts                      = try(each.value["timeouts"], null)
  tags                          = try(each.value["tags"], var.tags)
}
