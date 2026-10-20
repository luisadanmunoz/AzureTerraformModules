################################################################################
# String Variable Outputs
################################################################################

output "string_variable_ids" {
  description = "Map of string variable names to their IDs."
  value = {
    for name, var in azurerm_automation_variable_string.this :
    name => var.id
  }
}

################################################################################
# Integer Variable Outputs
################################################################################

output "int_variable_ids" {
  description = "Map of integer variable names to their IDs."
  value = {
    for name, var in azurerm_automation_variable_int.this :
    name => var.id
  }
}

################################################################################
# Boolean Variable Outputs
################################################################################

output "bool_variable_ids" {
  description = "Map of boolean variable names to their IDs."
  value = {
    for name, var in azurerm_automation_variable_bool.this :
    name => var.id
  }
}

################################################################################
# DateTime Variable Outputs
################################################################################

output "datetime_variable_ids" {
  description = "Map of datetime variable names to their IDs."
  value = {
    for name, var in azurerm_automation_variable_datetime.this :
    name => var.id
  }
}

################################################################################
# Object Variable Outputs
################################################################################

output "object_variable_ids" {
  description = "Map of object variable names to their IDs."
  value = {
    for name, var in azurerm_automation_variable_object.this :
    name => var.id
  }
}

################################################################################
# All Variables
################################################################################

output "all_variable_ids" {
  description = "Map of all variable names to their IDs (merged)."
  value = merge(
    { for name, var in azurerm_automation_variable_string.this : name => var.id },
    { for name, var in azurerm_automation_variable_int.this : name => var.id },
    { for name, var in azurerm_automation_variable_bool.this : name => var.id },
    { for name, var in azurerm_automation_variable_datetime.this : name => var.id },
    { for name, var in azurerm_automation_variable_object.this : name => var.id }
  )
}
