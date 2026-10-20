#############################################################################
# LOAD BALANCER
#############################################################################
module "load_balancer_external" {
  source = "./modules/load_balancer_external"

  for_each = var.load_balancer_external

  name                 = each.value["name"]
  resource_group_name  = each.value["resource_group_name"]
  location             = each.value["location"]
  sku                  = each.value["sku"]
  name_ip              = each.value["public_ip_address"]
  public_ip_address_id = element([for k, v in module.public_ip : v.id if v.name == each.value["public_ip_address"]], 0)

  #############################################################################
  # BACKEND
  #############################################################################
  network_interface_id_01  = element([for k, v in module.palo_alto : v.id if v.name == each.value["network_interface_nva1"]], 0)
  ip_configuration_name_01 = each.value["ip_configuration_name_01"]
  network_interface_id_02  = element([for k, v in module.palo_alto : v.id if v.name == each.value["network_interface_nva2"]], 0)
  ip_configuration_name_02 = each.value["ip_configuration_name_02"]
  #############################################################################
  # BACKEND
  #############################################################################
  backend_address_pool_ids = each.value["backend_address_pool_ids"]
  #############################################################################
  # LOAD BALANCER - DIAGNOSTIC SETTING
  #############################################################################
  name_diagnostic_setting = each.value["name_diagnostic_setting"]
  workspace_resource_id   = element([for k, v in module.log_analytics : v.id if v.name == each.value["workspace"]], 0)

  tags = var.tags

}
