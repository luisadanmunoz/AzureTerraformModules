################################################################################
# Local Values
################################################################################

locals {
  # Naming
  generated_name = join("-", compact([var.name_prefix, var.workload, var.environment, var.instance]))
  resource_name  = var.name != null ? var.name : local.generated_name

  # Tags
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "AVDHostPool"
  }
  tags = merge(local.default_tags, var.tags)

  # Helper flags
  is_personal = var.type == "Personal"
  is_pooled   = var.type == "Pooled"
}
