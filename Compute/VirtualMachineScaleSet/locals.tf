locals {
  # Naming
  generated_name = join("-", compact([var.name_prefix, var.workload, var.environment, var.instance]))
  resource_name  = var.name != null ? var.name : local.generated_name

  # Tags
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "VirtualMachineScaleSet"
  }
  tags = merge(local.default_tags, var.tags)

  # OS type flags
  is_linux   = var.os_type == "Linux"
  is_windows = var.os_type == "Windows"

  # Admin password
  use_generated_password = var.generate_admin_password && var.admin_password == null
  admin_password         = local.use_generated_password ? random_password.admin[0].result : var.admin_password
}
