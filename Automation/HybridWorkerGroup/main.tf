################################################################################
# Hybrid Worker Groups
# DEPENDENCY: Automation Account must exist.
# DEPENDENCY: Credential must exist (if credential_name is specified).
################################################################################

resource "azurerm_automation_hybrid_runbook_worker_group" "this" {
  for_each = var.create ? var.hybrid_worker_groups : {}

  name                    = each.key
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  credential_name         = each.value.credential_name
}

################################################################################
# Hybrid Workers (Azure VMs)
# DEPENDENCY: Hybrid Worker Group must exist.
# DEPENDENCY: VM must exist with Hybrid Worker extension installed.
################################################################################

resource "azurerm_automation_hybrid_runbook_worker" "this" {
  for_each = var.create ? var.hybrid_workers : {}

  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  worker_group_name       = each.value.group_name
  vm_resource_id          = each.value.vm_resource_id
  worker_id               = each.key

  depends_on = [azurerm_automation_hybrid_runbook_worker_group.this]
}
