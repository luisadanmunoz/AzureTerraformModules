#############################################################################
# AZURE FIREWALL OUTPUT
#############################################################################
output "id" {
  value = azurerm_firewall_policy.firewall_policy.id
}
output "name" {
  value = azurerm_firewall_policy.firewall_policy.name
}
output "policy_id" {
  value = azurerm_firewall_policy.firewall_policy.id
}
output "policy_name" {
  value = azurerm_firewall_policy.firewall_policy.name
}
