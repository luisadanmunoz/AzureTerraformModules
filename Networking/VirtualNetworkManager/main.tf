################################################################################
# Virtual Network Manager
################################################################################

# DEPENDENCY: Resource Group must exist before creating this resource
resource "azurerm_network_manager" "this" {
  count = var.create ? 1 : 0

  name                = local.vnm_name
  resource_group_name = var.resource_group_name # DEPENDENCY: Resource Group
  location            = var.location            # DEPENDENCY: Should align with Resource Group location

  scope_accesses = var.scope_accesses
  description    = var.description

  scope {
    management_group_ids = length(var.scope.management_group_ids) > 0 ? var.scope.management_group_ids : null
    subscription_ids     = length(var.scope.subscription_ids) > 0 ? var.scope.subscription_ids : null
  }

  tags = local.tags
}

################################################################################
# Network Groups
################################################################################

resource "azurerm_network_manager_network_group" "this" {
  count = var.create ? length(var.network_groups) : 0

  name               = var.network_groups[count.index].name
  network_manager_id = azurerm_network_manager.this[0].id
  description        = var.network_groups[count.index].description
}

################################################################################
# Network Group Static Members
################################################################################

resource "azurerm_network_manager_static_member" "this" {
  count = var.create ? length(local.network_group_static_members) : 0

  name                      = local.network_group_static_members[count.index].name
  network_group_id          = azurerm_network_manager_network_group.this[local.network_group_static_members[count.index].network_group_index].id
  target_virtual_network_id = local.network_group_static_members[count.index].target_virtual_network_id
}

################################################################################
# Connectivity Configurations
################################################################################

resource "azurerm_network_manager_connectivity_configuration" "this" {
  count = var.create ? length(var.connectivity_configurations) : 0

  name                  = var.connectivity_configurations[count.index].name
  network_manager_id    = azurerm_network_manager.this[0].id
  connectivity_topology = var.connectivity_configurations[count.index].connectivity_topology
  description           = var.connectivity_configurations[count.index].description

  global_mesh_enabled             = var.connectivity_configurations[count.index].global_mesh_enabled
  delete_existing_peering_enabled = var.connectivity_configurations[count.index].delete_existing_peering_enabled

  dynamic "applies_to_group" {
    for_each = var.connectivity_configurations[count.index].applies_to_group

    content {
      group_connectivity  = applies_to_group.value.group_connectivity
      network_group_id    = applies_to_group.value.network_group_id
      use_hub_gateway     = applies_to_group.value.use_hub_gateway
      global_mesh_enabled = applies_to_group.value.global_mesh_enabled
    }
  }

  dynamic "hub" {
    for_each = var.connectivity_configurations[count.index].hub != null ? [var.connectivity_configurations[count.index].hub] : []

    content {
      resource_id   = hub.value.resource_id
      resource_type = hub.value.resource_type
    }
  }
}

################################################################################
# Security Admin Configurations
################################################################################

resource "azurerm_network_manager_security_admin_configuration" "this" {
  count = var.create ? length(var.security_admin_configurations) : 0

  name               = var.security_admin_configurations[count.index].name
  network_manager_id = azurerm_network_manager.this[0].id
  description        = var.security_admin_configurations[count.index].description
}

################################################################################
# Admin Rule Collections
################################################################################

resource "azurerm_network_manager_admin_rule_collection" "this" {
  count = var.create ? length(local.security_rule_collections) : 0

  name                            = local.security_rule_collections[count.index].name
  security_admin_configuration_id = azurerm_network_manager_security_admin_configuration.this[local.security_rule_collections[count.index].config_index].id
  description                     = local.security_rule_collections[count.index].description
  network_group_ids               = local.security_rule_collections[count.index].network_group_ids
}

################################################################################
# Admin Rules
################################################################################

resource "azurerm_network_manager_admin_rule" "this" {
  count = var.create ? length(local.security_admin_rules) : 0

  name                     = local.security_admin_rules[count.index].name
  admin_rule_collection_id = azurerm_network_manager_admin_rule_collection.this[
    index(local.security_rule_collections[*].name, local.security_admin_rules[count.index].collection_key)
  ].id
  description             = local.security_admin_rules[count.index].description
  action                  = local.security_admin_rules[count.index].action
  direction               = local.security_admin_rules[count.index].direction
  priority                = local.security_admin_rules[count.index].priority
  protocol                = local.security_admin_rules[count.index].protocol
  source_port_ranges      = local.security_admin_rules[count.index].source_port_ranges
  destination_port_ranges = local.security_admin_rules[count.index].destination_port_ranges

  dynamic "source" {
    for_each = local.security_admin_rules[count.index].source

    content {
      address_prefix      = source.value.address_prefix
      address_prefix_type = source.value.address_prefix_type
    }
  }

  dynamic "destination" {
    for_each = local.security_admin_rules[count.index].destination

    content {
      address_prefix      = destination.value.address_prefix
      address_prefix_type = destination.value.address_prefix_type
    }
  }
}
