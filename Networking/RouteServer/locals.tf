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

  route_server_name = var.name != null ? var.name : local.generated_name

  pip_name = "pip-${local.route_server_name}"

  default_tags = {
    "terraform-managed" = "true"
    "module"            = "RouteServer"
  }

  tags = merge(local.default_tags, var.tags)

  # Determine the Public IP ID to use for the Route Server
  public_ip_id = var.public_ip_address_id != null ? var.public_ip_address_id : (
    var.create ? azurerm_public_ip.this[0].id : null
  )

  # Build a map of BGP connections for for_each
  bgp_connections_map = { for conn in var.bgp_connections : conn.name => conn }
}
