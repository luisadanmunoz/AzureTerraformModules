################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "StaticWebApp"
  }

  tags = merge(local.default_tags, var.tags)
}
