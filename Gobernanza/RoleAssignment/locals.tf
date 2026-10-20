locals {
  # ──────────────────────────────────────────────────────────────────────────────
  # Default tags
  # ──────────────────────────────────────────────────────────────────────────────
  default_tags = {
    "terraform-managed" = "true"
    "module"            = "RoleAssignment"
  }

  # ──────────────────────────────────────────────────────────────────────────────
  # Merge role assignments from all sources into a single map
  # ──────────────────────────────────────────────────────────────────────────────

  # Standard role_assignments list → map keyed by index
  standard_assignments = {
    for idx, ra in var.role_assignments :
    "std-${idx}" => ra
  }

  # Resource Group scoped assignments → map with scope injected
  rg_assignments = {
    for key, ra in var.resource_group_role_assignments :
    "rg-${key}" => {
      scope                                  = ra.resource_group_id
      role_definition_name                   = ra.role_definition_name
      role_definition_id                     = ra.role_definition_id
      principal_id                           = ra.principal_id
      principal_type                         = ra.principal_type
      condition                              = null
      condition_version                      = null
      description                            = ra.description
      skip_service_principal_aad_check       = ra.skip_service_principal_aad_check
      delegated_managed_identity_resource_id = null
      name                                   = null
    }
  }

  # All assignments merged
  all_assignments = var.create ? merge(local.standard_assignments, local.rg_assignments) : {}
}
