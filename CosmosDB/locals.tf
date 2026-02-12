locals {
  # Generate name from components if name is not explicitly provided
  name_components = compact([
    var.name_prefix,
    var.workload,
    var.environment,
    var.instance
  ])

  generated_name = join("-", local.name_components)

  # Use explicit name if provided, otherwise use generated name
  resource_name = coalesce(var.name, local.generated_name)

  # Default tags applied to all resources
  default_tags = {
    terraform-managed = "true"
    module            = "CosmosDB"
  }

  # Merge default tags with user-provided tags
  # User-provided tags take precedence over default tags
  tags = merge(local.default_tags, var.tags)

  # Default geo location if none provided - uses the primary location
  default_geo_locations = [{
    location          = var.location
    failover_priority = 0
    zone_redundant    = false
  }]

  # Use provided geo locations or default
  geo_locations = coalesce(var.geo_locations, local.default_geo_locations)
}
