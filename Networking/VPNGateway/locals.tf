################################################################################
# Local Values
################################################################################

locals {
  generated_name = join("-", compact([var.name_prefix, var.workload, var.environment, var.instance]))
  gateway_name   = var.name != null ? var.name : local.generated_name

  default_tags = {
    "terraform-managed" = "true"
    "module"            = "VPNGateway"
  }
  tags = merge(local.default_tags, var.tags)

  # Determine if AZ SKU
  is_az_sku = can(regex("AZ$", var.sku))

  # Create Public IPs
  create_public_ip           = var.create && var.public_ip_id == null
  create_public_ip_secondary = var.create && var.active_active && var.public_ip_id_secondary == null

  # Diagnostic settings
  create_diagnostic_settings = var.create && var.diagnostic_settings != null && (
    var.diagnostic_settings.log_analytics_workspace_id != null ||
    var.diagnostic_settings.storage_account_id != null
  )
}
