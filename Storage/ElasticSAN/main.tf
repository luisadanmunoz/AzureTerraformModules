################################################################################
# Azure Elastic SAN
################################################################################

resource "azurerm_elastic_san" "this" {
  count = var.create ? 1 : 0

  name                = local.resource_name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name = var.sku.name
    tier = var.sku.tier
  }

  base_size_in_tib     = var.base_size_in_tib
  extended_size_in_tib = var.extended_size_in_tib
  zones                = var.zones

  tags = local.tags
}

################################################################################
# Azure Elastic SAN Volume Groups
################################################################################

resource "azurerm_elastic_san_volume_group" "this" {
  for_each = var.create ? var.volume_groups : {}

  name           = each.value.name
  elastic_san_id = azurerm_elastic_san.this[0].id

  encryption_type = each.value.encryption_type
  protocol_type   = each.value.protocol_type

  dynamic "encryption" {
    for_each = each.value.encryption != null ? [each.value.encryption] : []

    content {
      key_vault_key_id          = encryption.value.key_vault_key_id
      user_assigned_identity_id = encryption.value.user_assigned_identity_id
    }
  }

  dynamic "network_rule" {
    for_each = each.value.network_rules != null ? each.value.network_rules.virtual_network_rules : []

    content {
      subnet_id = network_rule.value.subnet_id
      action    = network_rule.value.action
    }
  }

  dynamic "identity" {
    for_each = each.value.encryption != null && each.value.encryption.user_assigned_identity_id != null ? [1] : []

    content {
      type         = "UserAssigned"
      identity_ids = [each.value.encryption.user_assigned_identity_id]
    }
  }
}

################################################################################
# Azure Elastic SAN Volumes
################################################################################

resource "azurerm_elastic_san_volume" "this" {
  for_each = local.volumes_with_group_ids

  name            = each.value.name
  volume_group_id = each.value.volume_group_id
  size_in_gib     = each.value.size_in_gib

  dynamic "create_source" {
    for_each = each.value.create_source != null ? [each.value.create_source] : []

    content {
      source_id   = create_source.value.source_id
      source_type = create_source.value.source_type
    }
  }
}
