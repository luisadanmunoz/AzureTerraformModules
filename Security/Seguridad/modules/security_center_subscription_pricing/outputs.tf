#############################################################################
# OUTPUT SECURITY CENTER SUBSCRIPTION PRICING
#############################################################################
output "id" {
  value = azurerm_security_center_subscription_pricing.security_center_subscription_pricing.id
}

output "resource_type" {
  value = var.resource_type
}
