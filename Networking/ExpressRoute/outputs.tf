################################################################################
# ExpressRoute Circuit Outputs
################################################################################

output "id" {
  description = "The ID of the ExpressRoute Circuit."
  value       = var.create ? azurerm_express_route_circuit.this[0].id : null
}

output "name" {
  description = "The name of the ExpressRoute Circuit."
  value       = var.create ? azurerm_express_route_circuit.this[0].name : null
}

output "service_key" {
  description = "The service key of the ExpressRoute Circuit."
  value       = var.create ? azurerm_express_route_circuit.this[0].service_key : null
  sensitive   = true
}

output "service_provider_provisioning_state" {
  description = "The provisioning state of the ExpressRoute Circuit with the service provider."
  value       = var.create ? azurerm_express_route_circuit.this[0].service_provider_provisioning_state : null
}
