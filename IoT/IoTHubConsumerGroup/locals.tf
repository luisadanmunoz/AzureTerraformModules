################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "IoTHubConsumerGroup"
  }

  tags = merge(local.default_tags, var.tags)
}
