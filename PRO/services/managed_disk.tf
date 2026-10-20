#############################################################################
# MANAGED DISK
#############################################################################

module "managed_disk" {
  source = "./modules/managed_disk"

  for_each = var.managed_disk

  name                 = each.value["name"]
  location             = each.value["location"]
  resource_group_name  = each.value["resource_group_name"]
  storage_account_type = each.value["storage_account_type"]
  create_option        = each.value["create_option"]
  disk_size_gb         = each.value["disk_size_gb"]
  virtual_machine_id   = element([for k, v in module.windows_vm : v.id if v.name == each.value["vm_name"]], 0)
  #virtual_machine_id = length(module.windows_vm) > 0 ? element([for k, v in module.windows_vm : v.id if v.name == "vmeuwestproad01"], 0) : null

  lun     = each.value["lun"]
  caching = each.value["caching"]

  commom_tags = var.commom_tags


  depends_on = [module.windows_vm]

}