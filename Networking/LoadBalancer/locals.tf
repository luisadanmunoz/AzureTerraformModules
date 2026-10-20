################################################################################
# Local Values
################################################################################

locals {
  generated_name = join("-", compact([var.name_prefix, var.workload, var.environment, var.instance]))
  lb_name        = var.name != null ? var.name : local.generated_name

  default_tags = {
    "terraform-managed" = "true"
    "module"            = "LoadBalancer"
  }
  tags = merge(local.default_tags, var.tags)

  create_diagnostic_settings = var.create && var.diagnostic_settings != null && (
    var.diagnostic_settings.log_analytics_workspace_id != null ||
    var.diagnostic_settings.storage_account_id != null
  )
}
