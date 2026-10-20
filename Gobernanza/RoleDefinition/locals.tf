################################################################################
# Local Values
################################################################################

locals {
  assignable_scopes = var.assignable_scopes != null ? var.assignable_scopes : [var.scope]
}
