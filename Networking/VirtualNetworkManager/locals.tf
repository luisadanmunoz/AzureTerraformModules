################################################################################
# Local Values
################################################################################

locals {
  # Naming convention: prefix-workload-environment-vnm-instance
  # Example: vnm-hub-prod-vnm-001
  generated_name = join("-", compact([
    var.name_prefix,
    var.workload,
    var.environment,
    "vnm",
    var.instance
  ]))

  # Use explicit name if provided, otherwise use generated name
  vnm_name = var.name != null ? var.name : local.generated_name

  # Merge default tags with user-provided tags
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "VirtualNetworkManager"
  }

  tags = merge(local.default_tags, var.tags)

  # Flatten network group static members for iteration
  network_group_static_members = flatten([
    for ng_idx, ng in var.network_groups : [
      for sm in ng.static_members : {
        network_group_key             = ng.name
        network_group_index           = ng_idx
        name                          = sm.name
        target_virtual_network_id     = sm.target_virtual_network_id
      }
    ]
  ])

  # Flatten security admin rule collections for iteration
  security_rule_collections = flatten([
    for sac_idx, sac in var.security_admin_configurations : [
      for rc in sac.rule_collections : {
        config_key        = sac.name
        config_index      = sac_idx
        name              = rc.name
        description       = rc.description
        network_group_ids = rc.network_group_ids
        rules             = rc.rules
      }
    ]
  ])

  # Flatten security admin rules for iteration
  security_admin_rules = flatten([
    for rc in local.security_rule_collections : [
      for rule in rc.rules : {
        config_key              = rc.config_key
        config_index            = rc.config_index
        collection_key          = rc.name
        name                    = rule.name
        description             = rule.description
        action                  = rule.action
        direction               = rule.direction
        priority                = rule.priority
        protocol                = rule.protocol
        source_port_ranges      = rule.source_port_ranges
        destination_port_ranges = rule.destination_port_ranges
        source                  = rule.source
        destination             = rule.destination
      }
    ]
  ])
}
