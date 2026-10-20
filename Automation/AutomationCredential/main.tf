################################################################################
# Automation Credentials
# DEPENDENCY: Automation Account must exist.
################################################################################

resource "azurerm_automation_credential" "this" {
  for_each = var.create ? var.credentials : {}

  name                    = each.key
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  username                = each.value.username
  password                = each.value.password
  description             = each.value.description
}
