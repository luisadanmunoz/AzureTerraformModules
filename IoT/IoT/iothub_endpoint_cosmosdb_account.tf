#############################################################################
# IOT HUB ENDPOINT COSMOSDB ACCOUNTS
#############################################################################
module "iothub_endpoint_cosmosdb_account" {
  source = "./modules/iothub_endpoint_cosmosdb_account"

  for_each = var.iothub_endpoint_cosmosdb_accounts

  iothub_endpoint_cosmosdb_account_name = each.value["iothub_endpoint_cosmosdb_account_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  iothub_id = try(
    element([for _, iothub in module.iothub : iothub.id if iothub.name == each.value["iothub_name"]], 0),
    each.value["iothub_id"]
  )
  container_name         = each.value["container_name"]
  database_name          = each.value["database_name"]
  endpoint_uri           = each.value["endpoint_uri"]
  authentication_type    = try(each.value["authentication_type"], null)
  identity_id            = try(each.value["identity_id"], null)
  partition_key_name     = try(each.value["partition_key_name"], null)
  partition_key_template = try(each.value["partition_key_template"], null)
  primary_key            = try(each.value["primary_key"], null)
  secondary_key          = try(each.value["secondary_key"], null)
  subscription_id        = try(each.value["subscription_id"], null)
  timeouts               = try(each.value["timeouts"], null)
}
