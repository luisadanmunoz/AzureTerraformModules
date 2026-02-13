################################################################################
# Local Values
################################################################################

locals {
  # Extract VM name from ID for outputs
  vm_name = try(element(split("/", var.source_vm_id), length(split("/", var.source_vm_id)) - 1), null)
}
