locals {
  # Naming
  generated_name = join("-", compact([var.name_prefix, var.workload, var.environment, var.instance]))
  resource_name  = var.name != null ? var.name : local.generated_name

  # Tags
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "MaintenanceConfiguration"
  }
  tags = merge(local.default_tags, var.tags)
}
