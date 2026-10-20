#############################################################################
# OUTPUT SSH PUBLIC KEY
#############################################################################
output "id" {
  value = azurerm_ssh_public_key.ssh_public_key.id
}

output "name" {
  value = azurerm_ssh_public_key.ssh_public_key.name
}

output "public_key" {
  value = azurerm_ssh_public_key.ssh_public_key.public_key
}
