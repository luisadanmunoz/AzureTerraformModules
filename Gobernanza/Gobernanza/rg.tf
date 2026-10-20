#############################################################################
# RESOURCE GROUPS
#############################################################################
module "rg" {
  source = "./modules/rg"

  for_each = var.resources_groups

  resource_group_name = each.value["resource_group_name"]
  location            = each.value["location"]

  tags = try(each.value["tags"], var.tags)
}
