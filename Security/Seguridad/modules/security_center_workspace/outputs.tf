#############################################################################
# OUTPUT SECURITY CENTER WORKSPACE
#############################################################################
output "id" {
  value = azurerm_security_center_workspace.security_center_workspace.id
}

output "scope" {
  value = var.scope
}

output "workspace_id" {
  value = var.workspace_id
}
