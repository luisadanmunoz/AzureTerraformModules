################################################################################
# Local Values
################################################################################

locals {
  # Naming convention: prefix-workload-environment-instance-suffix
  generated_name = join("-", compact([
    var.name_prefix,
    var.workload,
    var.environment,
    var.instance,
    var.name_suffix
  ]))

  pip_name = var.name != null ? var.name : local.generated_name

  default_tags = {
    "terraform-managed" = "true"
    "module"            = "PublicIP"
  }

  tags = merge(local.default_tags, var.tags)

  create_diagnostic_settings = var.create && var.diagnostic_settings != null && (
    var.diagnostic_settings.log_analytics_workspace_id != null ||
    var.diagnostic_settings.storage_account_id != null ||
    var.diagnostic_settings.eventhub_authorization_rule_id != null
  )
}
