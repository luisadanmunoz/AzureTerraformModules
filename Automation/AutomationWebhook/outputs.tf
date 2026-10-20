################################################################################
# Webhook Outputs
################################################################################

output "webhook_ids" {
  description = "Map of webhook names to their IDs."
  value = {
    for name, wh in azurerm_automation_webhook.this :
    name => wh.id
  }
}

output "webhook_names" {
  description = "List of created webhook names."
  value       = keys(azurerm_automation_webhook.this)
}

output "webhook_uris" {
  description = "Map of webhook names to their URIs. SENSITIVE: Store securely."
  value = {
    for name, wh in azurerm_automation_webhook.this :
    name => wh.uri
  }
  sensitive = true
}

output "webhook_expiry_times" {
  description = "Map of webhook names to their expiry times."
  value = {
    for name, wh in azurerm_automation_webhook.this :
    name => wh.expiry_time
  }
}
