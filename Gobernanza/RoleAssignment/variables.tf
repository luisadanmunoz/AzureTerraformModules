################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the role assignment."
  type        = bool
  default     = true
}

################################################################################
# Role Assignment
################################################################################

variable "role_assignments" {
  description = <<-EOT
    (Optional) List of role assignments to create. Each object supports:
    - scope: (Required) The scope at which the Role Assignment applies (Management Group, Subscription, Resource Group, or Resource ID). DEPENDENCY: Scope resource must exist.
    - role_definition_name: (Optional) The name of a built-in Role (e.g., "Contributor", "Reader"). Conflicts with role_definition_id.
    - role_definition_id: (Optional) The Scoped-ID of the Role Definition. Conflicts with role_definition_name.
    - principal_id: (Required) The ID of the Principal (User, Group, or Service Principal) to assign the Role Definition to. DEPENDENCY: Principal must exist in Azure AD.
    - principal_type: (Optional) The type of the principal_id. Possible values: User, Group, ServicePrincipal, ForeignGroup, Device. Setting this avoids a silent API lookup.
    - condition: (Optional) The condition that limits the resources that the role can be assigned to.
    - condition_version: (Optional) The version of the condition syntax. Required if condition is set. Values: "1.0", "2.0".
    - description: (Optional) The description for this Role Assignment.
    - skip_service_principal_aad_check: (Optional) Skip the Azure AD check for service principals. Defaults to false.
    - delegated_managed_identity_resource_id: (Optional) The delegated Azure Resource ID which contains a Managed Identity.
    - name: (Optional) A UUID for the Role Assignment. A new UUID will be generated if not provided.
  EOT
  type = list(object({
    scope                                  = string
    role_definition_name                   = optional(string, null)
    role_definition_id                     = optional(string, null)
    principal_id                           = string
    principal_type                         = optional(string, null)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    delegated_managed_identity_resource_id = optional(string, null)
    name                                   = optional(string, null)
  }))
  default = []

  validation {
    condition = alltrue([
      for ra in var.role_assignments :
      (ra.role_definition_name != null || ra.role_definition_id != null) &&
      !(ra.role_definition_name != null && ra.role_definition_id != null)
    ])
    error_message = "Each role assignment must specify either 'role_definition_name' or 'role_definition_id', but not both."
  }

  validation {
    condition = alltrue([
      for ra in var.role_assignments :
      ra.principal_type == null || contains(["User", "Group", "ServicePrincipal", "ForeignGroup", "Device"], ra.principal_type)
    ])
    error_message = "principal_type must be one of: User, Group, ServicePrincipal, ForeignGroup, Device."
  }

  validation {
    condition = alltrue([
      for ra in var.role_assignments :
      ra.condition_version == null || contains(["1.0", "2.0"], ra.condition_version)
    ])
    error_message = "condition_version must be '1.0' or '2.0'."
  }

  validation {
    condition = alltrue([
      for ra in var.role_assignments :
      (ra.condition == null && ra.condition_version == null) ||
      (ra.condition != null && ra.condition_version != null)
    ])
    error_message = "condition and condition_version must both be set or both be null."
  }
}

################################################################################
# Scoped Role Assignments (convenience variables)
################################################################################

variable "subscription_id" {
  description = "(Optional) The Subscription ID to use as scope. Conflicts with scope in role_assignments."
  type        = string
  default     = null
}

variable "resource_group_role_assignments" {
  description = <<-EOT
    (Optional) Map of role assignments scoped to a specific Resource Group. Key is a unique identifier.
    - resource_group_id: (Required) The Resource Group ID as scope. DEPENDENCY: Resource Group must exist.
    - role_definition_name: (Optional) Built-in role name. Conflicts with role_definition_id.
    - role_definition_id: (Optional) Scoped role definition ID. Conflicts with role_definition_name.
    - principal_id: (Required) The principal ID. DEPENDENCY: Principal must exist.
    - principal_type: (Optional) Type of principal.
    - description: (Optional) Description for the assignment.
    - skip_service_principal_aad_check: (Optional) Skip AAD check. Defaults to false.
  EOT
  type = map(object({
    resource_group_id                = string
    role_definition_name             = optional(string, null)
    role_definition_id               = optional(string, null)
    principal_id                     = string
    principal_type                   = optional(string, null)
    description                      = optional(string, null)
    skip_service_principal_aad_check = optional(bool, false)
  }))
  default = {}
}
