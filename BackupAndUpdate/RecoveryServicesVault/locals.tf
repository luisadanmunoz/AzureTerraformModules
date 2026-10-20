################################################################################
# Local Values
################################################################################

locals {
  # Naming
  generated_name = join("-", compact([var.name_prefix, var.workload, var.environment, var.instance]))
  resource_name  = var.name != null ? var.name : local.generated_name

  # Tags
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "RecoveryServicesVault"
  }
  tags = merge(local.default_tags, var.tags)

  # Diagnostic settings
  enable_diagnostics = var.diagnostic_settings != null && (
    var.diagnostic_settings.log_analytics_workspace_id != null ||
    var.diagnostic_settings.storage_account_id != null ||
    var.diagnostic_settings.eventhub_authorization_rule_id != null
  )
}
