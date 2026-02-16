################################################################################
# Outputs
################################################################################

output "id" {
  description = "The ID of the Azure Firewall."
  value       = var.create ? azurerm_firewall.this[0].id : null
}

output "name" {
  description = "The name of the Azure Firewall."
  value       = var.create ? azurerm_firewall.this[0].name : null
}

output "ip_configuration" {
  description = "The IP configuration list of the Azure Firewall."
  value       = var.create ? azurerm_firewall.this[0].ip_configuration : null
}

output "private_ip_address" {
  description = "The private IP address of the Azure Firewall."
  value       = var.create ? azurerm_firewall.this[0].ip_configuration[0].private_ip_address : null
}

output "virtual_hub" {
  description = "The virtual hub configuration of the Azure Firewall, including private and public IP addresses."
  value       = var.create ? azurerm_firewall.this[0].virtual_hub : null
}

output "resource_group_name" {
  description = "The resource group name of the Azure Firewall."
  value       = var.create ? azurerm_firewall.this[0].resource_group_name : null
}

output "location" {
  description = "The location of the Azure Firewall."
  value       = var.create ? azurerm_firewall.this[0].location : null
}
