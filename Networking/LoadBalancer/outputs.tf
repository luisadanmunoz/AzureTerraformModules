################################################################################
# Load Balancer Outputs
################################################################################

output "id" {
  description = "The ID of the Load Balancer."
  value       = var.create ? azurerm_lb.this[0].id : null
}

output "name" {
  description = "The name of the Load Balancer."
  value       = var.create ? azurerm_lb.this[0].name : null
}

output "frontend_ip_configuration" {
  description = "Frontend IP configurations."
  value       = var.create ? azurerm_lb.this[0].frontend_ip_configuration : null
}

output "private_ip_address" {
  description = "Private IP address (internal LB)."
  value       = var.create && var.type == "internal" ? try(azurerm_lb.this[0].frontend_ip_configuration[0].private_ip_address, null) : null
}

output "backend_address_pool_ids" {
  description = "Map of backend pool names to IDs."
  value       = { for k, v in azurerm_lb_backend_address_pool.this : k => v.id }
}

output "probe_ids" {
  description = "Map of probe names to IDs."
  value       = { for k, v in azurerm_lb_probe.this : k => v.id }
}

output "lb_rule_ids" {
  description = "Map of rule names to IDs."
  value       = { for k, v in azurerm_lb_rule.this : k => v.id }
}

output "nat_rule_ids" {
  description = "Map of NAT rule names to IDs."
  value       = { for k, v in azurerm_lb_nat_rule.this : k => v.id }
}
