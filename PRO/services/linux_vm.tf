module "azurerm_linux_virtual_machine" {
  source = "./modules/linux_vm"

  for_each = var.linux_vm

  #############################################################################
  # RANDOM PASSWORD
  #############################################################################
  keyvault_id = element([for k, v in module.keyvault : v.id if v.name == each.value["keyvault"]], 0)
  #############################################################################
  # LINUX VIRTUAL MACHINE MODULE
  #############################################################################
  vm_name             = each.value["vm_name"]
  location            = each.value["location"]
  resource_group_name = each.value["resource_group_name"]
  size                = each.value["size"]
  admin_username      = each.value["admin_username"]
  publisher           = each.value["publisher"]
  offer               = each.value["offer"]
  sku                 = each.value["sku"]
  os_version          = each.value["os_version"]
  #############################################################################
  # LINUX VIRTUAL MACHINE MODULE - NETWORK INTERFACE
  #############################################################################
  subnet_id                     = element([for k, v in module.subnet : v.id if v.name == each.value["subnet_name_key"]], 0)
  private_ip_address_allocation = each.value["private_ip_address_allocation"]
  private_ip_address            = try(each.value["private_ip_address"], null)

  tags = var.tags

}