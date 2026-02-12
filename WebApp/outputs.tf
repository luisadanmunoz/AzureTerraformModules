# -----------------------------------------------------------------------------
# Web App Outputs
# -----------------------------------------------------------------------------

output "id" {
  description = "The ID of the Web App"
  value       = local.is_linux ? try(azurerm_linux_web_app.this[0].id, null) : try(azurerm_windows_web_app.this[0].id, null)
}

output "name" {
  description = "The name of the Web App"
  value       = local.is_linux ? try(azurerm_linux_web_app.this[0].name, null) : try(azurerm_windows_web_app.this[0].name, null)
}

output "default_hostname" {
  description = "The default hostname of the Web App"
  value       = local.is_linux ? try(azurerm_linux_web_app.this[0].default_hostname, null) : try(azurerm_windows_web_app.this[0].default_hostname, null)
}

output "outbound_ip_addresses" {
  description = "A comma-separated list of outbound IP addresses for the Web App"
  value       = local.is_linux ? try(azurerm_linux_web_app.this[0].outbound_ip_addresses, null) : try(azurerm_windows_web_app.this[0].outbound_ip_addresses, null)
}

output "possible_outbound_ip_addresses" {
  description = "A comma-separated list of possible outbound IP addresses for the Web App"
  value       = local.is_linux ? try(azurerm_linux_web_app.this[0].possible_outbound_ip_addresses, null) : try(azurerm_windows_web_app.this[0].possible_outbound_ip_addresses, null)
}

output "identity" {
  description = "The managed identity of the Web App"
  value = var.identity != null ? {
    principal_id = local.is_linux ? try(azurerm_linux_web_app.this[0].identity[0].principal_id, null) : try(azurerm_windows_web_app.this[0].identity[0].principal_id, null)
    tenant_id    = local.is_linux ? try(azurerm_linux_web_app.this[0].identity[0].tenant_id, null) : try(azurerm_windows_web_app.this[0].identity[0].tenant_id, null)
  } : null
}
