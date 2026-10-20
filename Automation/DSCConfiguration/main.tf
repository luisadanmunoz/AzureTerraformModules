################################################################################
# DSC Configurations
# DEPENDENCY: Automation Account must exist.
################################################################################

resource "azurerm_automation_dsc_configuration" "this" {
  for_each = var.create ? var.configurations : {}

  name                    = each.key
  resource_group_name     = var.resource_group_name
  location                = var.location
  automation_account_name = var.automation_account_name

  content_embedded = each.value.content_embedded
  description      = each.value.description
  log_verbose      = each.value.log_verbose

  tags = local.tags
}
