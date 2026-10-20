locals {
  is_linux   = var.os_type == "Linux"
  is_windows = var.os_type == "Windows"

  publisher            = "Microsoft.Azure.Monitor"
  linux_type           = "AzureMonitorLinuxAgent"
  windows_type         = "AzureMonitorWindowsAgent"
  type_handler_version = "1.0"

  settings = var.user_assigned_identity_id != null ? jsonencode({
    authentication = {
      managedIdentity = {
        identifier-name  = "mi_res_id"
        identifier-value = var.user_assigned_identity_id
      }
    }
  }) : null

  default_tags = {
    "terraform-managed" = "true"
    "module"            = "VMExtension-AzureMonitorAgent"
  }
  tags = merge(local.default_tags, var.tags)
}
