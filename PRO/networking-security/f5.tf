#############################################################################
# RESOURCES F5 
#############################################################################
module "f5" {
  source = "./modules/f5"

  for_each = var.f5

  name                = each.value["name"]
  resource_group_name = each.value["resource_group_name"]
  location            = each.value["location"]
  size                = each.value["size"]
  subnet_mgmt_id      = element([for k, v in module.subnet : v.id if v.name == each.value["subnet_mgmt"]], 0)
  subnet_private_id   = element([for k, v in module.subnet : v.id if v.name == each.value["subnet_private"]], 0)
  subnet_public_id    = element([for k, v in module.subnet : v.id if v.name == each.value["subnet_public"]], 0)
  subnet_public_id_2  = element([for k, v in module.subnet : v.id if v.name == each.value["subnet_public"]], 0)
  zone                = each.value["zone"]
  ip_public           = each.value["ip_public"]
  ip_public_2         = each.value["ip_public_2"]
  ip_private          = each.value["ip_private"]
  ip_management       = each.value["ip_management"]
  //public_ip_address_id = element([for k, v in module.public_ip : v.id if v.name == each.value["public_ip_address"]], 0)
  //keyvault_id = element([for k, v in module.keyvault : v.id if v.name == each.value["keyvault"]], 0)
}