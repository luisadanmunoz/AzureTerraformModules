################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "ResourceMover"
  }

  tags = merge(local.default_tags, var.tags)
}
