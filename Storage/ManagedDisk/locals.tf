locals {
  # Generate a name from components if explicit name is not provided
  name_parts = compact([
    var.name_prefix,
    var.workload,
    var.environment,
    var.instance
  ])

  generated_name = join("-", local.name_parts)

  # Use explicit name if provided, otherwise use generated name
  resource_name = coalesce(var.name, local.generated_name)

  # Default tags applied to all resources created by this module
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "ManagedDisk"
  }

  # Merge default tags with user-provided tags (user tags take precedence)
  tags = merge(local.default_tags, var.tags)
}
