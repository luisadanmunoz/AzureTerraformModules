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

  nat_gateway_name = var.name != null ? var.name : local.generated_name

  pip_name = var.public_ip_name != null ? var.public_ip_name : "pip-${local.nat_gateway_name}"

  default_tags = {
    "terraform-managed" = "true"
    "module"            = "NATGateway"
  }

  tags = merge(local.default_tags, var.tags)

  # Combine created and provided public IP IDs
  all_public_ip_ids = concat(
    var.create && var.create_public_ip ? [azurerm_public_ip.this[0].id] : [],
    var.public_ip_ids
  )
}
