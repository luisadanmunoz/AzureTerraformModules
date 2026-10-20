################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "DigitalTwins"
  }

  tags = merge(local.default_tags, var.tags)
}
