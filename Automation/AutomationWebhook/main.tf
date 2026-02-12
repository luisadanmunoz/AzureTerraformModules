################################################################################
# Automation Webhooks
# DEPENDENCY: Automation Account must exist.
# DEPENDENCY: Runbook must exist.
# DEPENDENCY: Hybrid Worker Group must exist (if run_on_worker_group specified).
################################################################################

resource "azurerm_automation_webhook" "this" {
  for_each = var.create ? var.webhooks : {}

  name                    = each.key
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  runbook_name            = each.value.runbook_name
  expiry_time             = each.value.expiry_time
  enabled                 = each.value.enabled
  parameters              = each.value.parameters
  run_on_worker_group     = each.value.run_on_worker_group
  uri                     = each.value.uri
}
