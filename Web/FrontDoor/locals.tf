################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "FrontDoor"
  }

  tags = merge(local.default_tags, var.tags)
}
