################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "IoTHubDPS"
  }

  tags = merge(local.default_tags, var.tags)
}
