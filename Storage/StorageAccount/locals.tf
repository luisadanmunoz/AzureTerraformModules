################################################################################
# Local Values
################################################################################

locals {
  # Naming convention: prefix + workload + environment + instance
  # Storage Account names must be 3-24 chars, lowercase letters and numbers only (no hyphens)
  # Example: stshareddev001
  generated_name = lower(join("", compact([
    var.name_prefix,
    var.workload,
    var.environment,
    var.instance
  ])))

  # Use explicit name if provided, otherwise use generated name
  resource_name = var.name != null ? var.name : local.generated_name

  # Merge default tags with user-provided tags
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "StorageAccount"
  }

  tags = merge(local.default_tags, var.tags)

  # Determine if diagnostic settings should be created
  create_diagnostic_settings = var.create && var.diagnostic_settings != null && (
    var.diagnostic_settings.log_analytics_workspace_id != null ||
    var.diagnostic_settings.storage_account_id != null ||
    var.diagnostic_settings.eventhub_authorization_rule_id != null
  )
}
