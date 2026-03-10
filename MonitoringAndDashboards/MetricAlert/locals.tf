################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "MetricAlert"
  }

  tags = merge(local.default_tags, var.tags)
}
