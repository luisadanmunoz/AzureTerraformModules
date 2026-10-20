#############################################################################
# OUTPUT SECURITY CENTER SETTING
#############################################################################
output "id" {
  value = azurerm_security_center_setting.security_center_setting.id
}

output "setting_name" {
  value = var.setting_name
}
