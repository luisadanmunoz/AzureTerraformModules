################################################################################
# Schedule Outputs
################################################################################

output "id" {
  description = "The ID of the Automation Schedule."
  value       = var.create ? azurerm_automation_schedule.this[0].id : null
}

output "name" {
  description = "The name of the Automation Schedule."
  value       = var.create ? azurerm_automation_schedule.this[0].name : null
}

output "start_time" {
  description = "The start time of the Schedule."
  value       = var.create ? azurerm_automation_schedule.this[0].start_time : null
}

output "expiry_time" {
  description = "The expiry time of the Schedule."
  value       = var.create ? azurerm_automation_schedule.this[0].expiry_time : null
}

output "frequency" {
  description = "The frequency of the Schedule."
  value       = var.create ? azurerm_automation_schedule.this[0].frequency : null
}

output "interval" {
  description = "The interval of the Schedule."
  value       = var.create ? azurerm_automation_schedule.this[0].interval : null
}
