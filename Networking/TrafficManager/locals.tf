################################################################################
# Local Values
################################################################################

locals {
  generated_name = join("-", compact([var.name_prefix, var.workload, var.environment, var.instance]))
  tm_name        = var.name != null ? var.name : local.generated_name

  dns_relative_name = var.dns_config_relative_name != null ? var.dns_config_relative_name : local.tm_name

  default_tags = {
    "terraform-managed" = "true"
    "module"            = "TrafficManager"
  }
  tags = merge(local.default_tags, var.tags)

  # Separate endpoints by type for distinct resource creation
  azure_endpoints = {
    for idx, ep in var.endpoints : ep.name => ep
    if ep.type == "azureEndpoints"
  }

  external_endpoints = {
    for idx, ep in var.endpoints : ep.name => ep
    if ep.type == "externalEndpoints"
  }

  nested_endpoints = {
    for idx, ep in var.endpoints : ep.name => ep
    if ep.type == "nestedEndpoints"
  }

  create_diagnostic_settings = var.create && var.diagnostic_settings != null && (
    var.diagnostic_settings.log_analytics_workspace_id != null ||
    var.diagnostic_settings.storage_account_id != null ||
    var.diagnostic_settings.eventhub_authorization_rule_id != null
  )
}
