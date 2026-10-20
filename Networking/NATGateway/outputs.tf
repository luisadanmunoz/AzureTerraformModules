################################################################################
# NAT Gateway Outputs
################################################################################

output "id" {
  description = "The ID of the NAT Gateway."
  value       = var.create ? azurerm_nat_gateway.this[0].id : null
}

output "name" {
  description = "The name of the NAT Gateway."
  value       = var.create ? azurerm_nat_gateway.this[0].name : null
}

output "resource_group_name" {
  description = "The name of the Resource Group."
  value       = var.create ? azurerm_nat_gateway.this[0].resource_group_name : null
}

output "resource_guid" {
  description = "The resource GUID of the NAT Gateway."
  value       = var.create ? azurerm_nat_gateway.this[0].resource_guid : null
}

################################################################################
# Public IP Outputs
################################################################################

output "public_ip_id" {
  description = "The ID of the created Public IP (if created)."
  value       = var.create && var.create_public_ip ? azurerm_public_ip.this[0].id : null
}

output "public_ip_address" {
  description = "The IP address of the created Public IP (if created)."
  value       = var.create && var.create_public_ip ? azurerm_public_ip.this[0].ip_address : null
}

output "all_public_ip_ids" {
  description = "All Public IP IDs associated with the NAT Gateway."
  value       = local.all_public_ip_ids
}
