#############################################################################
# OUTPUTS IOT HUB DPS SHARED ACCESS POLICY
#############################################################################
output "id" {
  description = "value of the iot hub dps shared access policy id"
  value       = azurerm_iothub_dps_shared_access_policy.iothub_dps_shared_access_policy.id
}

output "name" {
  description = "value of the iot hub dps shared access policy name"
  value       = azurerm_iothub_dps_shared_access_policy.iothub_dps_shared_access_policy.name
}
