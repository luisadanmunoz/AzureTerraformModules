locals {
  # Generate name from components if name is not provided
  name_parts = compact([
    var.name_prefix,
    var.workload,
    var.environment,
    var.instance
  ])

  generated_name = join("-", local.name_parts)

  # Use provided name or fall back to generated name
  resource_name = coalesce(var.name, local.generated_name)

  # Default tags for all resources
  default_tags = {
    terraform-managed = "true"
    module            = "NetAppAccount"
  }

  # Merge default tags with user-provided tags (user tags take precedence)
  tags = merge(local.default_tags, var.tags)
}
