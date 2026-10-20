################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "ArcServer"
  }

  tags = merge(local.default_tags, var.tags)
}
