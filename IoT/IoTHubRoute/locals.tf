################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "IoTHubRoute"
  }

  tags = merge(local.default_tags, var.tags)
}
