#############################################################################
# WINDOWS VIRTUAL MACHINE MODULE
#############################################################################

module "windows_vm" {
  source = "./modules/windows_vm"

  for_each = var.windows_vm

  #############################################################################
  # KEY VAULT SECRET
  #############################################################################
  keyvault_id = element([for k, v in module.keyvault : v.id if v.name == each.value["keyvault"]], 0)
  #############################################################################
  # WINDOWS VIRTUAL MACHINE
  #############################################################################
  vm_name              = each.value["vm_name"]
  computer_name        = each.value["computer_name"]
  resource_group_name  = each.value["resource_group_name"]
  location             = each.value["location"]
  size                 = each.value["size"]
  admin_username       = each.value["admin_username"]
  zone                 = each.value["zone"]
  license_type         = each.value["license_type"]
  caching              = each.value["caching"]
  storage_account_type = each.value["storage_account_type"]
  publisher            = each.value["publisher"]
  offer                = each.value["offer"]
  sku                  = each.value["sku"]
  os_version           = each.value["os_version"]
  #############################################################################
  # WINDOWS VIRTUAL MACHINE MODULE - NETWORK INTERFACE
  #############################################################################
  subnet_id                     = element([for k, v in module.subnet : v.id if v.name == each.value["subnet_name_key"]], 0)
  private_ip_address_allocation = each.value["private_ip_address_allocation"]
  private_ip_address            = try(each.value["private_ip_address"], null)
  #public_ip_address_id = length([for k, v in module.public_ip : v.id if v.name == each.value["public_ip"]]) > 0 ? element([for k, v in module.public_ip : v.id if v.name == each.value["public_ip"]], 0) : null
  #############################################################################
  # WINDOWS VIRTUAL MACHINE MODULE - MANAGED DISK
  #############################################################################
  #create_option                 = each.value["create_option"]
  #disk_size_gb                  = each.value["disk_size_gb"]
  #tier                          = each.value["tier"]
  #############################################################################
  # WINDOWS VIRTUAL MACHINE MODULE - DATA DISK ATTACHMENT
  #############################################################################
  #lun                          = each.value["lun"]
  #############################################################################
  # WINDOWS VIRTUAL MACHINE BACKUP PROTECTED
  #############################################################################
  #recovery_vault_name           = each.value["recovery_vault_name"]
  #backup_policy_id              = element([for k, v in module.recovery_service_vault : v.id if v.name == each.value["recovery_vault_name"]], 0) 
  #############################################################################
  # DIAGNOSTIC SETTINGS
  #############################################################################
  #name_diagnostic_setting = each.value["name_diagnostic_setting"]
  #workspace_resource_id   = element([for k, v in module.log_analytics : v.id if v.name == each.value["workspace"]], 0)

  tags = var.tags
}