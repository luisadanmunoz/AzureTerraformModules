################################################################################
# Azure Container Registry
################################################################################

# DEPENDENCY: Resource Group must exist
# DEPENDENCY: Key Vault Key must exist (if using CMK encryption)
# DEPENDENCY: User Assigned Identity must exist (if using UserAssigned identity)
# DEPENDENCY: Subnets must exist (if using virtual network rules)

resource "azurerm_container_registry" "this" {
  count = var.create ? 1 : 0

  name                = local.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku

  admin_enabled                 = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled
  network_rule_bypass_option    = var.network_rule_bypass_option

  # Premium-only features
  quarantine_policy_enabled = local.is_premium ? var.quarantine_policy_enabled : null
  zone_redundancy_enabled   = local.is_premium ? var.zone_redundancy_enabled : null
  export_policy_enabled     = local.is_premium ? var.export_policy_enabled : null
  anonymous_pull_enabled    = var.anonymous_pull_enabled
  data_endpoint_enabled     = local.is_premium ? var.data_endpoint_enabled : null

  # Identity
  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  # Geo-replications (Premium only)
  dynamic "georeplications" {
    for_each = local.is_premium ? var.georeplications : []

    content {
      location                  = georeplications.value.location
      regional_endpoint_enabled = georeplications.value.regional_endpoint_enabled
      zone_redundancy_enabled   = georeplications.value.zone_redundancy_enabled
      tags                      = georeplications.value.tags
    }
  }

  # Network rule set (Premium only)
  dynamic "network_rule_set" {
    for_each = local.is_premium && var.network_rule_set != null ? [var.network_rule_set] : []

    content {
      default_action = network_rule_set.value.default_action

      dynamic "ip_rule" {
        for_each = network_rule_set.value.ip_rules

        content {
          action   = ip_rule.value.action
          ip_range = ip_rule.value.ip_range
        }
      }

      dynamic "virtual_network" {
        for_each = network_rule_set.value.virtual_network_rules

        content {
          action    = virtual_network.value.action
          subnet_id = virtual_network.value.subnet_id
        }
      }
    }
  }

  # Retention policy (Premium only)
  dynamic "retention_policy" {
    for_each = local.is_premium && var.retention_policy != null ? [var.retention_policy] : []

    content {
      days    = retention_policy.value.days
      enabled = retention_policy.value.enabled
    }
  }

  # Trust policy (Premium only)
  dynamic "trust_policy" {
    for_each = local.is_premium && var.trust_policy != null ? [var.trust_policy] : []

    content {
      enabled = trust_policy.value.enabled
    }
  }

  # Encryption (Premium only)
  dynamic "encryption" {
    for_each = local.is_premium && var.encryption != null ? [var.encryption] : []

    content {
      enabled            = encryption.value.enabled
      key_vault_key_id   = encryption.value.key_vault_key_id
      identity_client_id = encryption.value.identity_client_id
    }
  }

  tags = local.tags
}

################################################################################
# Webhooks
################################################################################

resource "azurerm_container_registry_webhook" "this" {
  for_each = var.create ? { for wh in var.webhooks : wh.name => wh } : {}

  name                = each.value.name
  resource_group_name = var.resource_group_name
  registry_name       = azurerm_container_registry.this[0].name
  location            = var.location

  service_uri    = each.value.service_uri
  status         = each.value.status
  scope          = each.value.scope
  actions        = each.value.actions
  custom_headers = each.value.custom_headers

  tags = local.tags
}

################################################################################
# Scope Maps
################################################################################

resource "azurerm_container_registry_scope_map" "this" {
  for_each = var.create ? { for sm in var.scope_maps : sm.name => sm } : {}

  name                    = each.value.name
  container_registry_name = azurerm_container_registry.this[0].name
  resource_group_name     = var.resource_group_name
  description             = each.value.description
  actions                 = each.value.actions
}
