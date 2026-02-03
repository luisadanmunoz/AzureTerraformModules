################################################################################
# Local Values
################################################################################

locals {
  generated_name = join("-", compact([var.name_prefix, var.workload, var.environment, var.instance]))
  vwan_name      = var.name != null ? var.name : local.generated_name

  default_tags = {
    "terraform-managed" = "true"
    "module"            = "VirtualWAN"
  }
  tags = merge(local.default_tags, var.tags)

  # Build maps for for_each usage
  virtual_hubs_map = { for idx, hub in var.virtual_hubs : idx => hub }
  vpn_gateways_map = { for idx, gw in var.vpn_gateways : idx => gw }
  vpn_sites_map    = { for idx, site in var.vpn_sites : idx => site }
  er_gateways_map  = { for idx, gw in var.er_gateways : idx => gw }
}
