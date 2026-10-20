################################################################################
# Module Outputs
################################################################################

output "module_ids" {
  description = "Map of module names to their IDs."
  value = {
    for name, mod in azurerm_automation_module.this :
    name => mod.id
  }
}

output "module_names" {
  description = "List of imported module names."
  value       = keys(azurerm_automation_module.this)
}

output "modules" {
  description = "Full map of module resources with all attributes."
  value = {
    for name, mod in azurerm_automation_module.this :
    name => {
      id   = mod.id
      name = mod.name
    }
  }
}
