################################################################################
# Automation String Variables
# DEPENDENCY: Automation Account must exist.
################################################################################

resource "azurerm_automation_variable_string" "this" {
  for_each = var.create ? var.string_variables : {}

  name                    = each.key
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  value                   = each.value.value
  description             = each.value.description
  encrypted               = each.value.encrypted
}

################################################################################
# Automation Integer Variables
# DEPENDENCY: Automation Account must exist.
################################################################################

resource "azurerm_automation_variable_int" "this" {
  for_each = var.create ? var.int_variables : {}

  name                    = each.key
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  value                   = each.value.value
  description             = each.value.description
  encrypted               = each.value.encrypted
}

################################################################################
# Automation Boolean Variables
# DEPENDENCY: Automation Account must exist.
################################################################################

resource "azurerm_automation_variable_bool" "this" {
  for_each = var.create ? var.bool_variables : {}

  name                    = each.key
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  value                   = each.value.value
  description             = each.value.description
  encrypted               = each.value.encrypted
}

################################################################################
# Automation DateTime Variables
# DEPENDENCY: Automation Account must exist.
################################################################################

resource "azurerm_automation_variable_datetime" "this" {
  for_each = var.create ? var.datetime_variables : {}

  name                    = each.key
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  value                   = each.value.value
  description             = each.value.description
  encrypted               = each.value.encrypted
}

################################################################################
# Automation Object Variables (stored as JSON string)
# DEPENDENCY: Automation Account must exist.
################################################################################

resource "azurerm_automation_variable_object" "this" {
  for_each = var.create ? var.object_variables : {}

  name                    = each.key
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  value                   = jsonencode(each.value.value)
  description             = each.value.description
  encrypted               = each.value.encrypted
}
