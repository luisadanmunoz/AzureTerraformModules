#############################################################################
# NETWORK SECURITY GROUP
############################################################################# 
module "nsg" {
  source = "./modules/nsg"

  for_each = var.nsg

  name                = each.value["name"]
  location            = each.value["location"]
  resource_group_name = each.value["resource_group_name"]

  tags = var.tags

  depends_on = [module.rg]
  /*
#############################################################################
# DIAGNOSTIC SETTINGS
#############################################################################

  name_diagnostic_setting = each.value["name_diagnostic_setting"]
  workspace_resource_id   = element([for k, v in module.log_analytics : v.id if k == each.value["location"]], 0)
*/
}