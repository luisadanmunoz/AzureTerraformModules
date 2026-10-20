resource "azurerm_role_assignment" "role_assignment" {
  scope                            = var.scope
  principal_id                     = var.principal_id
  role_definition_name             = var.role_definition_name
  role_definition_id               = var.role_definition_id
  principal_type                   = var.principal_type
  description                      = var.description
  condition                        = var.condition
  condition_version                = var.condition_version
  skip_service_principal_aad_check = var.skip_service_principal_aad_check

  lifecycle {
    precondition {
      condition = (
        (var.role_definition_name != null && var.role_definition_id == null) ||
        (var.role_definition_name == null && var.role_definition_id != null)
      )
      error_message = "Set either role_definition_name or role_definition_id, but not both."
    }

    precondition {
      condition     = var.condition_version == null || contains(["1.0", "2.0"], var.condition_version)
      error_message = "condition_version must be null, 1.0, or 2.0."
    }

    precondition {
      condition     = var.condition_version == null || var.condition != null
      error_message = "condition must be provided when condition_version is set."
    }

    precondition {
      condition     = !var.skip_service_principal_aad_check || var.principal_type == "ServicePrincipal"
      error_message = "skip_service_principal_aad_check can only be true when principal_type is ServicePrincipal."
    }
  }
}
