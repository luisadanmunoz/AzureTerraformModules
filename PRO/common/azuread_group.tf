#############################################################################
# MODULE AZUREAD GROUP
#############################################################################

module "azuread_group" {
  source = "./modules/azuread_group"

  for_each = var.azuread_group

  group_name = each.value["group_name"]
  owners     = each.value["owners"]

}
