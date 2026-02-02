################################################################################
# Local Values
################################################################################

locals {
  generated_name = join("-", compact([
    var.name_prefix,
    var.workload,
    var.environment,
    var.instance,
    var.name_suffix
  ]))

  firewall_name = var.name != null ? var.name : local.generated_name

  default_tags = {
    "terraform-managed" = "true"
    "module"            = "AzureFirewall"
  }

  tags = merge(local.default_tags, var.tags)

  # Determine if we should create public IPs
  create_public_ips = var.create && length(var.public_ip_ids) == 0 && var.sku_name == "AZFW_VNet"

  # Get public IP IDs (either created or provided)
  public_ip_ids = local.create_public_ips ? [for pip in azurerm_public_ip.this : pip.id] : var.public_ip_ids

  # Diagnostic settings check
  create_diagnostic_settings = var.create && var.diagnostic_settings != null && (
    var.diagnostic_settings.log_analytics_workspace_id != null ||
    var.diagnostic_settings.storage_account_id != null ||
    var.diagnostic_settings.eventhub_authorization_rule_id != null
  )
}
