#############################################################################
# PUBLIC IP
#############################################################################
module "public_ip" {
  source = "./modules/pip"

  for_each = var.pip

  name                = each.value["name"]
  location            = each.value["location"]
  resource_group_name = each.value["resource_group_name"]
  allocation_method   = each.value["allocation_method"]
  sku                 = each.value["sku"]
  zones               = each.value["zones"]
  #############################################################################
  # DIAGNOSTIC SETTINGS
  #############################################################################
  name_diagnostic_setting = each.value["name_diagnostic_setting"]
  workspace_resource_id   = element([for k, v in module.log_analytics : v.id if v.name == each.value["log_analytics"]], 0)

  depends_on = [module.rg]

  tags = var.tags
} 