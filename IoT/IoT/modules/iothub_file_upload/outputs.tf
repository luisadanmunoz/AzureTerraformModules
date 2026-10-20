#############################################################################
# OUTPUTS IOT HUB FILE UPLOAD
#############################################################################
output "id" {
  description = "value of the iot hub file upload id"
  value       = azurerm_iothub_file_upload.iothub_file_upload.id
}
