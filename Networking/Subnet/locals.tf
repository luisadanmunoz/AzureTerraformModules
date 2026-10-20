################################################################################
# Local Values
################################################################################

locals {
  # Naming convention: prefix-workload-environment-instance-suffix
  # Example: snet-web-prod-001
  generated_name = join("-", compact([
    var.name_prefix,
    var.workload,
    var.environment,
    var.instance,
    var.name_suffix
  ]))

  # Use explicit name if provided, otherwise use generated name
  subnet_name = var.name != null ? var.name : local.generated_name

  # Determine if associations should be created
  create_nsg_association         = var.create && var.network_security_group_id != null
  create_route_table_association = var.create && var.route_table_id != null
  create_nat_gateway_association = var.create && var.nat_gateway_id != null
}
