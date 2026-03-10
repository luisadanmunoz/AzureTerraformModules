locals {
  # Naming
  generated_name = join("-", compact([var.name_prefix, var.workload, var.environment, var.instance]))
  resource_name  = var.name != null ? var.name : local.generated_name

  # Computer name (max 15 chars for Windows, 64 for Linux)
  computer_name = var.computer_name != null ? var.computer_name : (
    var.os_type == "Windows" ? substr(replace(local.resource_name, "-", ""), 0, 15) : substr(local.resource_name, 0, 64)
  )

  # Tags
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "VirtualMachine"
  }
  tags = merge(local.default_tags, var.tags)

  # OS type flags
  is_linux   = var.os_type == "Linux"
  is_windows = var.os_type == "Windows"

  # Network Interface
  create_nic            = var.create_network_interface && length(var.network_interface_ids) == 0
  network_interface_ids = local.create_nic ? [azurerm_network_interface.this[0].id] : var.network_interface_ids

  # Admin password
  use_generated_password = var.generate_admin_password && var.admin_password == null
  admin_password         = local.use_generated_password ? random_password.admin[0].result : var.admin_password
}
