################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "MLComputeInstance"
  }

  tags = merge(local.default_tags, var.tags)
}
