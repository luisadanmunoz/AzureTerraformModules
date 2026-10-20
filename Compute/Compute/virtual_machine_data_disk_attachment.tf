#############################################################################
# VIRTUAL MACHINE DATA DISK ATTACHMENTS
#############################################################################
module "virtual_machine_data_disk_attachment" {
  source = "./modules/virtual_machine_data_disk_attachment"

  for_each = var.virtual_machine_data_disk_attachments

  managed_disk_id = try(
    element([for _, managed_disk in module.managed_disk : managed_disk.id if managed_disk.name == each.value["managed_disk_name"]], 0),
    each.value["managed_disk_id"]
  )
  virtual_machine_id = try(
    element([for _, linux_virtual_machine in module.linux_virtual_machine : linux_virtual_machine.id if linux_virtual_machine.name == each.value["virtual_machine_name"]], 0),
    element([for _, windows_virtual_machine in module.windows_virtual_machine : windows_virtual_machine.id if windows_virtual_machine.name == each.value["virtual_machine_name"]], 0),
    each.value["virtual_machine_id"]
  )
  lun                       = each.value["lun"]
  caching                   = each.value["caching"]
  create_option             = try(each.value["create_option"], null)
  write_accelerator_enabled = try(each.value["write_accelerator_enabled"], null)
  timeouts                  = try(each.value["timeouts"], null)
}
