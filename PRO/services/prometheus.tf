#############################################################################
# LINUX VIRTUAL MACHINE - PROMETHEUS
#############################################################################
module "prometheus" {
  source = "./modules/prometheus"

  for_each = var.prometheus


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
  computer_name          = each.value["computer_name"]
  commom_tags            = var.commom_tags
  dcr_assoc_id           = element([for k, v in module.dcr : v.id_dcr_win if v.name_dcr_win == each.value["dcr_name"]], 0)
  dcr_vminsight_assoc_id = element([for k, v in module.dcr : v.id_vminsight if v.name_vminsight == each.value["dcr_vminsight_name"]], 0)


}