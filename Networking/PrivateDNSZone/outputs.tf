################################################################################
# Private DNS Zone Outputs
################################################################################

output "id" {
  description = "The ID of the Private DNS Zone."
  value       = var.create ? azurerm_private_dns_zone.this[0].id : null
}

output "name" {
  description = "The name of the Private DNS Zone."
  value       = var.create ? azurerm_private_dns_zone.this[0].name : null
}

output "resource_group_name" {
  description = "The name of the Resource Group."
  value       = var.create ? azurerm_private_dns_zone.this[0].resource_group_name : null
}

output "number_of_record_sets" {
  description = "The number of record sets in the zone."
  value       = var.create ? azurerm_private_dns_zone.this[0].number_of_record_sets : null
}

output "max_number_of_record_sets" {
  description = "The maximum number of record sets allowed."
  value       = var.create ? azurerm_private_dns_zone.this[0].max_number_of_record_sets : null
}

output "max_number_of_virtual_network_links" {
  description = "The maximum number of VNet links allowed."
  value       = var.create ? azurerm_private_dns_zone.this[0].max_number_of_virtual_network_links : null
}

################################################################################
# Virtual Network Link Outputs
################################################################################

output "virtual_network_link_ids" {
  description = "Map of VNet link names to their IDs."
  value       = { for k, v in azurerm_private_dns_zone_virtual_network_link.this : k => v.id }
}

################################################################################
# Record Outputs
################################################################################

output "a_record_ids" {
  description = "Map of A record names to their IDs."
  value       = { for k, v in azurerm_private_dns_a_record.this : k => v.id }
}

output "a_record_fqdns" {
  description = "Map of A record names to their FQDNs."
  value       = { for k, v in azurerm_private_dns_a_record.this : k => v.fqdn }
}

output "cname_record_ids" {
  description = "Map of CNAME record names to their IDs."
  value       = { for k, v in azurerm_private_dns_cname_record.this : k => v.id }
}

output "cname_record_fqdns" {
  description = "Map of CNAME record names to their FQDNs."
  value       = { for k, v in azurerm_private_dns_cname_record.this : k => v.fqdn }
}
