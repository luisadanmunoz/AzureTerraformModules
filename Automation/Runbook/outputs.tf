################################################################################
# Runbook Outputs
################################################################################

output "id" {
  description = "The ID of the Automation Runbook."
  value       = var.create ? azurerm_automation_runbook.this[0].id : null
}

output "name" {
  description = "The name of the Automation Runbook."
  value       = var.create ? azurerm_automation_runbook.this[0].name : null
}

output "runbook_type" {
  description = "The type of the Runbook."
  value       = var.create ? azurerm_automation_runbook.this[0].runbook_type : null
}

output "job_schedule_ids" {
  description = "Map of job schedule keys to their IDs."
  value = {
    for key, js in azurerm_automation_job_schedule.this :
    key => js.id
  }
}

output "job_schedule_job_ids" {
  description = "Map of job schedule keys to their job schedule UUIDs."
  value = {
    for key, js in azurerm_automation_job_schedule.this :
    key => js.job_schedule_id
  }
}
