################################################################################
# Local Values
################################################################################

locals {
  # Naming
  type_suffix    = var.type == "Desktop" ? "desktop" : "remoteapp"
  generated_name = join("-", compact([var.name_prefix, var.workload, local.type_suffix, var.environment, var.instance]))
  resource_name  = var.name != null ? var.name : local.generated_name

  # Tags
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "AVDApplicationGroup"
  }
  tags = merge(local.default_tags, var.tags)

  # Helper flags
  is_desktop   = var.type == "Desktop"
  is_remoteapp = var.type == "RemoteApp"
}
