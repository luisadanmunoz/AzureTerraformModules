################################################################################
# Automation PowerShell Modules
# DEPENDENCY: Automation Account must exist.
################################################################################

resource "azurerm_automation_module" "this" {
  for_each = var.create ? local.all_modules : {}

  name                    = each.key
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name

  module_link {
    uri = each.value.uri

    dynamic "hash" {
      for_each = each.value.hash != null ? [each.value.hash] : []
      content {
        algorithm = hash.value.algorithm
        value     = hash.value.value
      }
    }
  }
}
