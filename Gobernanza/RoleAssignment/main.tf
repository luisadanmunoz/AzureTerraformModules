################################################################################
# Role Assignment
# DEPENDENCY: Scope resources (Subscription, Resource Group, Resource) must exist.
# DEPENDENCY: Principal (User, Group, Service Principal) must exist in Azure AD.
# DEPENDENCY: Role Definition must exist (built-in or custom).
################################################################################

resource "azurerm_role_assignment" "this" {
  for_each = local.all_assignments

  # Use explicit name (UUID) if provided, otherwise let Azure generate one
  name = each.value.name

  # Scope
  scope = each.value.scope

  # Role Definition (either by name or ID)
  role_definition_name = each.value.role_definition_name
  role_definition_id   = each.value.role_definition_id

  # Principal
  principal_id   = each.value.principal_id
  principal_type = each.value.principal_type

  # Conditions (for ABAC - Attribute-Based Access Control)
  condition         = each.value.condition
  condition_version = each.value.condition_version

  # Description
  description = each.value.description

  # Performance optimization: skip AAD check for service principals
  skip_service_principal_aad_check = each.value.skip_service_principal_aad_check

  # Delegated managed identity
  delegated_managed_identity_resource_id = each.value.delegated_managed_identity_resource_id
}
