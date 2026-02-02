################################################################################
# Local Values
################################################################################

locals {
  # Naming convention: prefix-workload-environment-vnet-instance-suffix
  # Example: contoso-shared-dev-vnet-001
  generated_name = join("-", compact([
    var.name_prefix,
    var.workload,
    var.environment,
    "vnet",
    var.instance,
    var.name_suffix
  ]))

  # Use explicit name if provided, otherwise use generated name
  vnet_name = var.name != null ? var.name : local.generated_name

  # Merge default tags with user-provided tags
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "VirtualNetwork"
  }

  tags = merge(local.default_tags, var.tags)

  # Determine if diagnostic settings should be created
  create_diagnostic_settings = var.create && var.diagnostic_settings != null && (
    var.diagnostic_settings.log_analytics_workspace_id != null ||
    var.diagnostic_settings.storage_account_id != null ||
    var.diagnostic_settings.eventhub_authorization_rule_id != null
  )
}
