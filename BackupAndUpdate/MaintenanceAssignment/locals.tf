locals {
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "MaintenanceAssignment"
  }
  tags = merge(local.default_tags, var.tags)

  # Assignment type flags
  is_vm   = var.assignment_type == "VirtualMachine"
  is_host = var.assignment_type == "DedicatedHost"
  is_vmss = var.assignment_type == "VirtualMachineScaleSet"
  is_dyn  = var.assignment_type == "DynamicScope"
}
