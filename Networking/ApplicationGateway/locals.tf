################################################################################
# Local Values
################################################################################

locals {
  generated_name = join("-", compact([var.name_prefix, var.workload, var.environment, var.instance]))
  agw_name       = var.name != null ? var.name : local.generated_name

  default_tags = {
    "terraform-managed" = "true"
    "module"            = "ApplicationGateway"
  }
  tags = merge(local.default_tags, var.tags)

  # Frontend configuration names
  frontend_ip_config_public  = "frontend-ip-public"
  frontend_ip_config_private = "frontend-ip-private"

  # Determine if we need to create a Public IP
  create_public_ip = var.create && var.public_ip_id == null

  # Diagnostic settings
  create_diagnostic_settings = var.create && var.diagnostic_settings != null && (
    var.diagnostic_settings.log_analytics_workspace_id != null ||
    var.diagnostic_settings.storage_account_id != null
  )
}
