#############################################################################
# AZURE BASTION
#############################################################################
module "bastion" {
  source = "./modules/bastion"

  for_each = var.bastion

  name                 = each.value["name"]
  location             = each.value["location"]
  resource_group_name  = each.value["resource_group_name"]
  nameip               = each.value["nameip"]
  subnet_id            = element([for k, v in module.subnet : v.id if v.name == each.value["subnet"]], 0)
  public_ip_address_id = element([for k, v in module.public_ip : v.id if v.name == each.value["nameip"]], 0)
  sku                  = each.value["sku"]
  tunneling_enabled    = each.value["tunneling_enabled"]
  #############################################################################
  # DIAGNOSTIC SETTINGS
  #############################################################################
  name_diagnostic_setting = each.value["name_diagnostic_setting"]
  workspace_resource_id   = element([for k, v in module.log_analytics : v.id if v.name == each.value["log_analytics"]], 0)

  depends_on = [module.public_ip, module.subnet]
}