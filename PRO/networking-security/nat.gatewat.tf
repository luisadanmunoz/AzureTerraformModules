#############################################################################
# NAT GATEWAY
#############################################################################

module "nat_gateway" {
  source = "./modules/nat_gateway"

  for_each = var.nat_gateway

  name                = each.value["name"]
  location            = each.value["location"]
  resource_group_name = each.value["resource_group_name"]
  #############################################################################
  # NAT GATEWAY PUBLIC IP ASSOCIATION
  #############################################################################
  #public_ip_address_id = element([for k, v in module.public_ip : v.id if v.name == each.value["pip"]], 0)
  #############################################################################
  # NAT GATEWAY SUBNET ASSOCIATION - 1
  #############################################################################
  #subnet_id_1          = element([for k, v in module.subnet : v.id if v.name == each.value["subnet_1"]], 0)
  #############################################################################
  # NAT GATEWAY SUBNET ASSOCIATION - 2
  #############################################################################
  subnet_id_2 = element([for k, v in module.subnet : v.id if v.name == each.value["subnet_2"]], 0)

  tags = var.tags

  depends_on = [module.public_ip, module.subnet]
}