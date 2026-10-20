################################################################################
# Local Values
################################################################################

locals {
  # Naming: use explicit name if provided, otherwise generate from prefix/suffix
  generated_name = join("-", compact([
    var.name_prefix,
    var.name_suffix
  ]))

  # Use explicit name if provided, otherwise use generated name
  resource_name = var.name != null ? var.name : local.generated_name

  # Default tags applied to all resources created by this module
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "FileShare"
  }

  # Merge default tags with user-provided tags (user tags take precedence)
  tags = merge(local.default_tags, var.tags)
}
