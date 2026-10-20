#############################################################################
# COST ANOMALY ALERT
#############################################################################
module "cost_alert" {
  source = "../modules/cost_alert"

  for_each = var.cost_alert

  name            = each.value["name"]
  display_name    = each.value["display_name"]
  subscription_id = each.value["subscription_id"]
  email_subject   = each.value["email_subject"]
  email_addresses = each.value["email_addresses"]
}