#############################################################################
# LOG_ANALYTICS
#############################################################################
module "log_analytics" {
  source = "./modules/log_analytics"

  for_each = var.log_analytics

  name                = each.value["name"]
  location            = each.value["location"]
  resource_group_name = each.value["resource_group_name"]
  sku                 = each.value["sku"]
  retention_in_days   = each.value["retention_in_days"]

  tags = var.tags
}

