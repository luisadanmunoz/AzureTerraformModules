################################################################################
# Azure SQL Server (Logical Server)
################################################################################

# DEPENDENCY: Resource Group must exist
# DEPENDENCY: Key Vault Key must exist (if using TDE with CMK)
# DEPENDENCY: User Assigned Identity must exist (if using UserAssigned identity)
# DEPENDENCY: Subnets must exist with Microsoft.Sql service endpoint (if using virtual network rules)
# DEPENDENCY: Storage Account must exist (if using auditing with storage)

resource "azurerm_mssql_server" "this" {
  count = var.create ? 1 : 0

  name                = local.name
  resource_group_name = var.resource_group_name
  location            = var.location
  version             = var.version

  # Authentication - SQL Admin (required if not using Azure AD only)
  administrator_login          = var.azuread_administrator != null && var.azuread_administrator.azuread_authentication_only ? null : var.administrator_login
  administrator_login_password = var.azuread_administrator != null && var.azuread_administrator.azuread_authentication_only ? null : var.administrator_login_password

  # Security settings
  connection_policy                    = var.connection_policy
  minimum_tls_version                  = var.minimum_tls_version
  public_network_access_enabled        = var.public_network_access_enabled
  outbound_network_restriction_enabled = var.outbound_network_restriction_enabled

  # TDE with CMK
  transparent_data_encryption_key_vault_key_id = var.transparent_data_encryption_key_vault_key_id
  primary_user_assigned_identity_id            = var.primary_user_assigned_identity_id

  # Azure AD Administrator
  dynamic "azuread_administrator" {
    for_each = var.azuread_administrator != null ? [var.azuread_administrator] : []

    content {
      login_username              = azuread_administrator.value.login_username
      object_id                   = azuread_administrator.value.object_id
      tenant_id                   = azuread_administrator.value.tenant_id
      azuread_authentication_only = azuread_administrator.value.azuread_authentication_only
    }
  }

  # Identity
  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  tags = local.tags
}

################################################################################
# Firewall Rules
################################################################################

# Allow Azure Services
resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  count = var.create && var.allow_azure_services ? 1 : 0

  name             = "AllowAllWindowsAzureIps"
  server_id        = azurerm_mssql_server.this[0].id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

# Custom firewall rules
resource "azurerm_mssql_firewall_rule" "this" {
  for_each = var.create ? { for rule in var.firewall_rules : rule.name => rule } : {}

  name             = each.value.name
  server_id        = azurerm_mssql_server.this[0].id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address
}

################################################################################
# Virtual Network Rules
################################################################################

resource "azurerm_mssql_virtual_network_rule" "this" {
  for_each = var.create ? { for rule in var.virtual_network_rules : rule.name => rule } : {}

  name                                 = each.value.name
  server_id                            = azurerm_mssql_server.this[0].id
  subnet_id                            = each.value.subnet_id
  ignore_missing_vnet_service_endpoint = each.value.ignore_missing_vnet_service_endpoint
}

################################################################################
# Extended Auditing Policy
################################################################################

resource "azurerm_mssql_server_extended_auditing_policy" "this" {
  count = var.create && var.extended_auditing_policy != null ? 1 : 0

  server_id                               = azurerm_mssql_server.this[0].id
  enabled                                 = var.extended_auditing_policy.enabled
  storage_endpoint                        = var.extended_auditing_policy.storage_endpoint
  storage_account_access_key              = var.extended_auditing_policy.storage_account_access_key
  storage_account_access_key_is_secondary = var.extended_auditing_policy.storage_account_access_key_is_secondary
  retention_in_days                       = var.extended_auditing_policy.retention_in_days
  log_monitoring_enabled                  = var.extended_auditing_policy.log_monitoring_enabled
}

################################################################################
# Security Alert Policy
################################################################################

resource "azurerm_mssql_server_security_alert_policy" "this" {
  count = var.create && var.security_alert_policy != null ? 1 : 0

  server_name                = azurerm_mssql_server.this[0].name
  resource_group_name        = var.resource_group_name
  state                      = var.security_alert_policy.state
  disabled_alerts            = var.security_alert_policy.disabled_alerts
  email_account_admins       = var.security_alert_policy.email_account_admins
  email_addresses            = var.security_alert_policy.email_addresses
  retention_days             = var.security_alert_policy.retention_days
  storage_endpoint           = var.security_alert_policy.storage_endpoint
  storage_account_access_key = var.security_alert_policy.storage_account_access_key
}
