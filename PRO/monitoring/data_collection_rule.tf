#############################################################################
# RESOURCES DATA COLLECTION RULES
#############################################################################

module "dcr" {
  source = "./modules/data_collection_rule"

  for_each = var.data_collection_rule

  dcr_name                = each.value["dcr_name"]
  dcr_vminsight_name      = each.value["dcr_vminsight_name"]
  location                = each.value["location"]
  resource_group_name     = each.value["resource_group_name"]
  workspace_resource_id   = element([for k, v in module.log_analytics : v.id if k == each.value["location"]], 0)
  workspace_resource_name = each.value["workspace_resource_name"]

  tags = var.tags

}