locals {
  is_linux   = var.os_type == "Linux"
  is_windows = var.os_type == "Windows"

  linux_publisher            = "Microsoft.Azure.ActiveDirectory"
  linux_type                 = "AADSSHLoginForLinux"
  linux_type_handler_version = "1.0"

  windows_publisher            = "Microsoft.Azure.ActiveDirectory"
  windows_type                 = "AADLoginForWindows"
  windows_type_handler_version = "1.0"

  extension_name = var.name != null ? var.name : (local.is_linux ? "AADSSHLogin" : "AADLoginForWindows")

  default_tags = {
    "terraform-managed" = "true"
    "module"            = "VMExtension-AADLogin"
  }
  tags = merge(local.default_tags, var.tags)
}
