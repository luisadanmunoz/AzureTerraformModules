#############################################################################
# COST ANOMALY ALERT
#############################################################################
resource "azurerm_cost_anomaly_alert" "cost_alert" {
  name            = var.name
  display_name    = var.display_name
  subscription_id = "/subscriptions/${var.subscription_id}"
  email_subject   = var.email_subject
  email_addresses = var.email_addresses
}