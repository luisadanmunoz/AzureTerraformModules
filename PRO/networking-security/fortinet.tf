#############################################################################
# FORTINET
#############################################################################

module "fortinet" {
  source = "./modules/fortinet"

  for_each = var.fortinet

  secret_name                                 = each.value["secret_name"]
  keyvault_id                                 = element([for k, v in module.keyvault : v.id if k == each.value["location"]], 0)
  vm_name                                     = each.value["vm_name"]
  location                                    = each.value["location"]
  resource_group_name                         = each.value["resource_group_name"]
  subnet_id_ha                                = element([for k, v in module.subnet : v.id if v.name == each.value["subnet_ha"]], 0)
  private_ip_address_allocation_ha            = each.value["private_ip_address_allocation_ha"]
  private_ip_address_ha                       = try(each.value["private_ip_address_ha"], null)
  subnet_id_public                            = element([for k, v in module.subnet : v.id if v.name == each.value["subnet_public"]], 0)
  private_ip_address_allocation_public        = each.value["private_ip_address_allocation_public"]
  private_ip_address_public                   = try(each.value["private_ip_address_public"], null)
  private_ip_address_public_floating-public   = try(each.value["floating-public-ip"], null)
  public_ip_address_id                        = element([for k, v in module.public_ip : v.id if v.name == each.value["public_ip"]], 0)
  subnet_id_mgmt                              = element([for k, v in module.subnet : v.id if v.name == each.value["subnet_mgmt"]], 0)
  private_ip_address_allocation_mgmt          = each.value["private_ip_address_allocation_mgmt"]
  private_ip_address_mgmt                     = try(each.value["private_ip_address_mgmt"], null)
  subnet_id_private                           = element([for k, v in module.subnet : v.id if v.name == each.value["subnet_private"]], 0)
  private_ip_address_allocation_private       = each.value["private_ip_address_allocation_private"]
  private_ip_address_private                  = try(each.value["private_ip_address_private"], null)
  private_ip_address_private_floating-private = try(each.value["floating-private-ip"], null)
  size                                        = each.value["size"]
  admin_username                              = each.value["admin_username"]
  publisher                                   = each.value["publisher"]
  offer                                       = each.value["offer"]
  sku                                         = each.value["sku"]
  os_version                                  = each.value["os_version"]
  os_disk                                     = each.value["os_disk"]
  floating-public                             = each.value["floating-public"]
  floating-private                            = each.value["floating-private"]


  tags = var.tags

}
