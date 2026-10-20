#############################################################################
# VM LINUX GRAFANA
#############################################################################
module "grafana" {
  source = "./modules/grafana"

  for_each = var.grafana


  secret_name                   = each.value["secret_name"]
  keyvault_id                   = element([for k, v in module.keyvault : v.id if k == each.value["location"]], 0)
  vm_name                       = each.value["vm_name"]
  location                      = each.value["location"]
  resource_group_name           = each.value["resource_group_name"]
  subnet_id                     = element([for k, v in module.subnet : v.id if v.name == each.value["subnet_name_key"]], 0)
  private_ip_address_allocation = each.value["private_ip_address_allocation"]
  private_ip_address            = try(each.value["private_ip_address"], null)
  size                          = each.value["size"]
  admin_username                = each.value["admin_username"]
  //publisher                     = each.value ["publisher"]
  //offer                         = each.value ["offer"]
  //sku                           = each.value ["sku"]
  //os_version                    = each.value ["os_version"]
  //public_ip_address_id = element([for k, v in module.public_ip : v.id if v.name == each.value["public_ip_address"]], 0)
  computer_name = each.value["computer_name"]

  commom_tags = var.commom_tags

  depends_on = [module.prometheus]

}
