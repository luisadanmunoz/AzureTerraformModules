#############################################################################
# OUTPUT BASTION HOST
#############################################################################
output "id" {
  value = azurerm_bastion_host.bastion_host.id
}

output "name" {
  value = azurerm_bastion_host.bastion_host.name
}
