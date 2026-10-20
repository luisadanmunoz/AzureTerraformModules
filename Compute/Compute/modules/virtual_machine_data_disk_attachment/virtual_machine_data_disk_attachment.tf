#############################################################################
# VIRTUAL MACHINE DATA DISK ATTACHMENT
#############################################################################
resource "azurerm_virtual_machine_data_disk_attachment" "virtual_machine_data_disk_attachment" {
  managed_disk_id           = var.managed_disk_id
  virtual_machine_id        = var.virtual_machine_id
  lun                       = var.lun
  caching                   = var.caching
  create_option             = var.create_option
  write_accelerator_enabled = var.write_accelerator_enabled

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      update = try(timeouts.value["update"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }
}
