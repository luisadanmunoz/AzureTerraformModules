################################################################################
# Automation Certificates
# DEPENDENCY: Automation Account must exist.
################################################################################

resource "azurerm_automation_certificate" "this" {
  for_each = var.create ? var.certificates : {}

  name                    = each.key
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  base64                  = each.value.base64
  password                = each.value.password
  description             = each.value.description
  exportable              = each.value.exportable
}
