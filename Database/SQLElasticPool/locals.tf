################################################################################
# Local Values
################################################################################

locals {
  # Naming
  name = var.name != null ? var.name : "${var.name_prefix}-${var.workload}-${var.environment}-${var.instance}"

  # Default tags
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "SQLElasticPool"
  }
  tags = merge(local.default_tags, var.tags)
}
