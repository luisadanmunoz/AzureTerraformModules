################################################################################
# Function App Outputs
################################################################################

output "id" {
  description = "The ID of the Function App."
  value = var.create ? (
    local.is_linux ? azurerm_linux_function_app.this[0].id : azurerm_windows_function_app.this[0].id
  ) : null
}

output "name" {
  description = "The name of the Function App."
  value = var.create ? (
    local.is_linux ? azurerm_linux_function_app.this[0].name : azurerm_windows_function_app.this[0].name
  ) : null
}

output "default_hostname" {
  description = "The default hostname of the Function App."
  value = var.create ? (
    local.is_linux ? azurerm_linux_function_app.this[0].default_hostname : azurerm_windows_function_app.this[0].default_hostname
  ) : null
}

output "outbound_ip_addresses" {
  description = "A comma-separated list of outbound IP addresses."
  value = var.create ? (
    local.is_linux ? azurerm_linux_function_app.this[0].outbound_ip_addresses : azurerm_windows_function_app.this[0].outbound_ip_addresses
  ) : null
}

output "possible_outbound_ip_addresses" {
  description = "A comma-separated list of possible outbound IP addresses."
  value = var.create ? (
    local.is_linux ? azurerm_linux_function_app.this[0].possible_outbound_ip_addresses : azurerm_windows_function_app.this[0].possible_outbound_ip_addresses
  ) : null
}

output "identity" {
  description = "The identity block of the Function App."
  value = var.create ? (
    local.is_linux ? (
      length(azurerm_linux_function_app.this[0].identity) > 0 ? azurerm_linux_function_app.this[0].identity[0] : null
    ) : (
      length(azurerm_windows_function_app.this[0].identity) > 0 ? azurerm_windows_function_app.this[0].identity[0] : null
    )
  ) : null
}

output "principal_id" {
  description = "The Principal ID of the System Assigned Managed Identity."
  value = var.create ? (
    local.is_linux ? (
      length(azurerm_linux_function_app.this[0].identity) > 0 ? azurerm_linux_function_app.this[0].identity[0].principal_id : null
    ) : (
      length(azurerm_windows_function_app.this[0].identity) > 0 ? azurerm_windows_function_app.this[0].identity[0].principal_id : null
    )
  ) : null
}

output "tenant_id" {
  description = "The Tenant ID of the System Assigned Managed Identity."
  value = var.create ? (
    local.is_linux ? (
      length(azurerm_linux_function_app.this[0].identity) > 0 ? azurerm_linux_function_app.this[0].identity[0].tenant_id : null
    ) : (
      length(azurerm_windows_function_app.this[0].identity) > 0 ? azurerm_windows_function_app.this[0].identity[0].tenant_id : null
    )
  ) : null
}

output "kind" {
  description = "The Kind value of the Function App."
  value = var.create ? (
    local.is_linux ? azurerm_linux_function_app.this[0].kind : azurerm_windows_function_app.this[0].kind
  ) : null
}

output "os_type" {
  description = "The OS type of the Function App."
  value       = var.create ? var.os_type : null
}
