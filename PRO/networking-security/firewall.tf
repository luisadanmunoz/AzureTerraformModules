#############################################################################
# AZURE FIREWALL
#############################################################################
module "firewall" {
  source = "./modules/firewall"

  for_each = var.firewall

  name                            = each.value["name"]
  location                        = each.value["location"]
  resource_group_name             = each.value["resource_group_name"]
  subnet_id                       = element([for k, v in module.subnet : v.id if v.name == each.value["subnet_name"]], 0)
  public_ip_address_id            = element([for k, v in module.public_ip : v.id if v.name == each.value["public_ip"]], 0)
  management_name                 = each.value["management_name"]
  subnet_management_id            = element([for k, v in module.subnet : v.id if v.name == each.value["subnet_management"]], 0)
  management_public_ip_address_id = element([for k, v in module.public_ip : v.id if v.name == each.value["public_ip_management"]], 0)
  #############################################################################
  # AZURE FIREWALL POLICY
  #############################################################################
  name_firewall_policy = each.value["name_firewall_policy"]

  tags = var.tags
}