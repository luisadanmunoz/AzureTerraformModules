#############################################################################
# RESOURCE GROUPS
#############################################################################
module "resource_group" {
  source = "./modules/resource_group"

  for_each = var.resource_group

  resource_group_name = each.value["resource_group_name"]
  location            = each.value["location"]

  tags = var.tags
}