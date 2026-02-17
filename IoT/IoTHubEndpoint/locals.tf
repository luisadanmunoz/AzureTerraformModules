################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "IoTHubEndpoint"
  }

  tags = merge(local.default_tags, var.tags)
}
