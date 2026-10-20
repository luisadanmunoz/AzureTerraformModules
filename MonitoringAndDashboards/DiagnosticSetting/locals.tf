################################################################################
# Local Values
################################################################################

locals {
  default_tags = {
    ManagedBy = "Terraform"
    Module    = "DiagnosticSetting"
  }

  tags = merge(local.default_tags, var.tags)
}
