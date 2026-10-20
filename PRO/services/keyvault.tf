#############################################################################
# RESOURCES KEYVAULT
#############################################################################
module "keyvault" {
  source = "./modules/keyvault"

  for_each = var.keyvault

  name                = each.value["name"]
  location            = each.value["location"]
  resource_group_name = each.value["resource_group_name"]
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id_01        = each.value["object_id_01"]
  sku_name            = each.value["sku_name"]
  //name_diagnostic_setting = each.value["name_diagnostic_setting"]
  //workspace_resource_id   = element([for k, v in module.log_analytics : v.id if k == each.value["location"]], 0)
  subnet_id            = element([for k, v in module.subnet : v.id if v.name == each.value["subnet"]], 0)
  private_dns_zone_ids = element([for k, v in module.private_dns_zone : v.id if v.name == each.value["private_dns_zone_ids"]], 0)

  tags = var.tags

  depends_on = [module.subnet, module.private_dns_zone]
}