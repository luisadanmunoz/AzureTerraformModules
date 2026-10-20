################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "ArcKubernetes"
  }

  tags = merge(local.default_tags, var.tags)
}
