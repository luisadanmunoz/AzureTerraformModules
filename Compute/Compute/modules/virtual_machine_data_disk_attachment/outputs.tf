#############################################################################
# OUTPUT VIRTUAL MACHINE DATA DISK ATTACHMENT
#############################################################################
output "id" {
  value = azurerm_virtual_machine_data_disk_attachment.virtual_machine_data_disk_attachment.id
}
