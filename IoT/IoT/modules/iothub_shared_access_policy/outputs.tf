#############################################################################
# OUTPUTS IOT HUB SHARED ACCESS POLICY
#############################################################################
output "id" {
  description = "value of the iot hub shared access policy id"
  value       = azurerm_iothub_shared_access_policy.iothub_shared_access_policy.id
}

output "name" {
  description = "value of the iot hub shared access policy name"
  value       = azurerm_iothub_shared_access_policy.iothub_shared_access_policy.name
}
