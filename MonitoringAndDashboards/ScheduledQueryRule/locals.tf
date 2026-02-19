################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "ScheduledQueryRule"
  }

  tags = merge(local.default_tags, var.tags)
}
