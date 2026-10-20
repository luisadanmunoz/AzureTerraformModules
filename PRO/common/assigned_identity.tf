#############################################################################
# USER ASSIGNED IDENTITY
#############################################################################
module "assigned_identity" {
  source = "./module/assigned_identity"

  for_each = var.assigned_identity

  name                = each.value["name"]
  resource_group_name = each.value["resource_group_name"]
  location            = each.value["location"]

  depends_on = [module.resource_group]

  tags = var.tags

}