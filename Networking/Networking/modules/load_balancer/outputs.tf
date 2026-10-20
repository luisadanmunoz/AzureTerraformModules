#############################################################################
# OUTPUT LOAD BALANCER
#############################################################################
output "id" {
  value = azurerm_lb.load_balancer.id
}

output "name" {
  value = azurerm_lb.load_balancer.name
}

output "frontend_ip_configuration_ids" {
  value = {
    for configuration in azurerm_lb.load_balancer.frontend_ip_configuration :
    configuration.name => configuration.id
  }
}
