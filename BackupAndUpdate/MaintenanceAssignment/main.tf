################################################################################
# Maintenance Assignment - Virtual Machine
################################################################################

# DEPENDENCY: Maintenance Configuration must exist
# DEPENDENCY: Virtual Machine must exist (when assignment_type is VirtualMachine)

resource "azurerm_maintenance_assignment_virtual_machine" "this" {
  count = var.create && local.is_vm ? 1 : 0

  location                     = var.location
  maintenance_configuration_id = var.maintenance_configuration_id
  virtual_machine_id           = var.virtual_machine_id
}

################################################################################
# Maintenance Assignment - Dedicated Host
################################################################################

# DEPENDENCY: Dedicated Host must exist (when assignment_type is DedicatedHost)

resource "azurerm_maintenance_assignment_dedicated_host" "this" {
  count = var.create && local.is_host ? 1 : 0

  location                     = var.location
  maintenance_configuration_id = var.maintenance_configuration_id
  dedicated_host_id            = var.dedicated_host_id
}

################################################################################
# Maintenance Assignment - Virtual Machine Scale Set
################################################################################

# DEPENDENCY: VMSS must exist (when assignment_type is VirtualMachineScaleSet)

resource "azurerm_maintenance_assignment_virtual_machine_scale_set" "this" {
  count = var.create && local.is_vmss ? 1 : 0

  location                     = var.location
  maintenance_configuration_id = var.maintenance_configuration_id
  virtual_machine_scale_set_id = var.virtual_machine_scale_set_id
}

################################################################################
# Maintenance Assignment - Dynamic Scope
################################################################################

resource "azurerm_maintenance_assignment_dynamic_scope" "this" {
  count = var.create && local.is_dyn && var.dynamic_scope != null ? 1 : 0

  name                         = var.dynamic_scope.name
  maintenance_configuration_id = var.maintenance_configuration_id

  filter {
    locations       = var.dynamic_scope.filter.locations
    os_types        = var.dynamic_scope.filter.os_types
    resource_groups = var.dynamic_scope.filter.resource_groups
    resource_types  = var.dynamic_scope.filter.resource_types
    tag_filter      = var.dynamic_scope.filter.tag_filter

    dynamic "tags" {
      for_each = var.dynamic_scope.filter.tags
      content {
        tag    = tags.value.tag
        values = tags.value.values
      }
    }
  }
}
