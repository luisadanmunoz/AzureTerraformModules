#############################################################################
# FUNCTION APP
#############################################################################

module "function_app" {
  source = "./modules/function_app"

  for_each = var.function_app


  name_app_service_plan      = each.value["name_app_service_plan"]
  location                   = each.value["location"]
  resource_group_name        = each.value["resource_group_name"]
  name_function_app          = each.value["name_function_app"]
  storage_account_name       = each.value["storage_account_name"]
  storage_account_access_key = each.value["storage_account_access_key"]
  subnet_id                  = element([for k, v in module.subnet : v.id if v.name == each.value["subnet"]], 0)
  private_dns_zone_ids       = element([for k, v in module.private_dns_zone : v.id if v.name == each.value["private_dns_zone_ids"]], 0)

  tags = var.tags

  depends_on = [module.subnet, module.private_dns_zone]

}