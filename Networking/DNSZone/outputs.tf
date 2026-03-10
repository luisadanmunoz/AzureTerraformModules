output "id" {
  description = "The DNS Zone ID."
  value       = var.create ? azurerm_dns_zone.this[0].id : null
}

output "name" {
  description = "The DNS Zone name."
  value       = var.create ? azurerm_dns_zone.this[0].name : null
}

output "name_servers" {
  description = "The name servers for this DNS Zone."
  value       = var.create ? azurerm_dns_zone.this[0].name_servers : null
}

output "number_of_record_sets" {
  description = "The number of record sets."
  value       = var.create ? azurerm_dns_zone.this[0].number_of_record_sets : null
}

output "a_record_ids" {
  description = "Map of A record IDs."
  value       = { for k, v in azurerm_dns_a_record.this : k => v.id }
}

output "cname_record_ids" {
  description = "Map of CNAME record IDs."
  value       = { for k, v in azurerm_dns_cname_record.this : k => v.id }
}
