################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "MLComputeCluster"
  }

  tags = merge(local.default_tags, var.tags)
}
