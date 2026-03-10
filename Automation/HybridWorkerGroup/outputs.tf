################################################################################
# Hybrid Worker Group Outputs
################################################################################

output "group_ids" {
  description = "Map of Hybrid Worker Group names to their IDs."
  value = {
    for name, grp in azurerm_automation_hybrid_runbook_worker_group.this :
    name => grp.id
  }
}

output "group_names" {
  description = "List of created Hybrid Worker Group names."
  value       = keys(azurerm_automation_hybrid_runbook_worker_group.this)
}

################################################################################
# Hybrid Worker Outputs
################################################################################

output "worker_ids" {
  description = "Map of worker keys to their IDs."
  value = {
    for key, worker in azurerm_automation_hybrid_runbook_worker.this :
    key => worker.id
  }
}

output "worker_ips" {
  description = "Map of worker keys to their IP addresses."
  value = {
    for key, worker in azurerm_automation_hybrid_runbook_worker.this :
    key => worker.ip
  }
}

output "worker_last_seen" {
  description = "Map of worker keys to their last seen timestamps."
  value = {
    for key, worker in azurerm_automation_hybrid_runbook_worker.this :
    key => worker.last_seen_date_time
  }
}
