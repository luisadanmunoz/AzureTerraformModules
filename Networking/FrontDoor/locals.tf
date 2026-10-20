################################################################################
# Local Values
################################################################################

locals {
  generated_name = join("-", compact([var.name_prefix, var.workload, var.environment, var.instance]))
  afd_name       = var.name != null ? var.name : local.generated_name

  default_tags = {
    "terraform-managed" = "true"
    "module"            = "FrontDoor"
  }
  tags = merge(local.default_tags, var.tags)

  # Build lookup maps from list inputs for cross-referencing resources by name
  endpoint_map     = { for ep in var.endpoints : ep.name => ep }
  origin_group_map = { for og in var.origin_groups : og.name => og }
  origin_map       = { for o in var.origins : o.name => o }

  # Diagnostic settings
  create_diagnostic_settings = var.create && var.diagnostic_settings != null && (
    var.diagnostic_settings.log_analytics_workspace_id != null ||
    var.diagnostic_settings.storage_account_id != null
  )
}
