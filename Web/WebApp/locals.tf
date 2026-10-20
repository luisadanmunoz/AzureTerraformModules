locals {
  # Generate name from components if name is not provided
  name_components = compact([
    var.name_prefix,
    var.workload,
    var.environment,
    var.instance
  ])

  generated_name = join("-", local.name_components)

  # Use provided name or fall back to generated name
  resource_name = coalesce(var.name, local.generated_name)

  # Default tags applied to all resources
  default_tags = {
    terraform-managed = "true"
    module            = "WebApp"
  }

  # Merge default tags with user-provided tags
  tags = merge(local.default_tags, var.tags)

  # Determine which resource type to create based on OS type
  is_linux   = var.os_type == "Linux"
  is_windows = var.os_type == "Windows"
}
