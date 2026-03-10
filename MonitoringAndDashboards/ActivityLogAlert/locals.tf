################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "ActivityLogAlert"
  }

  tags = merge(local.default_tags, var.tags)
}
