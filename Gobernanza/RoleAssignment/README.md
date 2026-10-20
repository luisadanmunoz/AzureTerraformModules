# Azure Role Assignment Module

Terraform module to create and manage **Azure Role Assignments (RBAC)** at any scope (Management Group, Subscription, Resource Group, or Resource).

## Features

- Assign built-in or custom roles to Users, Groups, Service Principals, or Managed Identities
- Support for multiple assignments in a single module call
- ABAC (Attribute-Based Access Control) conditions support
- Convenience input for Resource Group-scoped assignments
- Conditional creation with `create = true/false`
- Input validation for role definitions, principal types, and conditions

## Usage - Basic (Built-in Role by Name)

```hcl
module "role_assignment" {
  source = "path/to/Gobernanza/RoleAssignment"

  role_assignments = [
    {
      scope                = "/subscriptions/00000000-0000-0000-0000-000000000000"
      role_definition_name = "Reader"
      principal_id         = "11111111-1111-1111-1111-111111111111"
      principal_type       = "Group"
      description          = "Grant Reader access to the security group"
    }
  ]
}
```

## Usage - Multiple Assignments

```hcl
module "role_assignments" {
  source = "path/to/Gobernanza/RoleAssignment"

  role_assignments = [
    {
      scope                = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-example"
      role_definition_name = "Contributor"
      principal_id         = "11111111-1111-1111-1111-111111111111"
      principal_type       = "ServicePrincipal"
      description          = "CI/CD pipeline contributor access"
      skip_service_principal_aad_check = true
    },
    {
      scope                = "/subscriptions/00000000-0000-0000-0000-000000000000"
      role_definition_name = "Reader"
      principal_id         = "22222222-2222-2222-2222-222222222222"
      principal_type       = "Group"
      description          = "Read-only access for auditors"
    }
  ]
}
```

## Usage - Resource Group Scoped (Convenience)

```hcl
module "rg_role_assignments" {
  source = "path/to/Gobernanza/RoleAssignment"

  resource_group_role_assignments = {
    contributor = {
      resource_group_id    = azurerm_resource_group.example.id
      role_definition_name = "Contributor"
      principal_id         = "11111111-1111-1111-1111-111111111111"
      principal_type       = "ServicePrincipal"
      skip_service_principal_aad_check = true
    }
    reader = {
      resource_group_id    = azurerm_resource_group.example.id
      role_definition_name = "Reader"
      principal_id         = "22222222-2222-2222-2222-222222222222"
      principal_type       = "Group"
    }
  }
}
```

## Usage - ABAC Conditions

```hcl
module "conditional_role" {
  source = "path/to/Gobernanza/RoleAssignment"

  role_assignments = [
    {
      scope                = "/subscriptions/00000000-0000-0000-0000-000000000000"
      role_definition_name = "Storage Blob Data Reader"
      principal_id         = "11111111-1111-1111-1111-111111111111"
      principal_type       = "User"
      condition_version    = "2.0"
      condition            = <<-EOT
        (
          !(ActionMatches{'Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read'})
          OR
          @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:name] StringEquals 'public-container'
        )
      EOT
    }
  ]
}
```

## Usage - Custom Role Definition ID

```hcl
module "custom_role" {
  source = "path/to/Gobernanza/RoleAssignment"

  role_assignments = [
    {
      scope              = "/subscriptions/00000000-0000-0000-0000-000000000000"
      role_definition_id = "/subscriptions/00000000-0000-0000-0000-000000000000/providers/Microsoft.Authorization/roleDefinitions/aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"
      principal_id       = "11111111-1111-1111-1111-111111111111"
      principal_type     = "ServicePrincipal"
    }
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create` | Controls whether to create the role assignments | `bool` | `true` | no |
| `role_assignments` | List of role assignment objects with scope, role, and principal | `list(object)` | `[]` | no |
| `subscription_id` | Subscription ID to use as scope (convenience) | `string` | `null` | no |
| `resource_group_role_assignments` | Map of role assignments scoped to Resource Groups | `map(object)` | `{}` | no |

### `role_assignments` Object Attributes

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `scope` | Scope at which the role applies (MG, Sub, RG, or Resource ID) | `string` | - | yes |
| `role_definition_name` | Built-in role name (e.g., "Contributor") | `string` | `null` | no* |
| `role_definition_id` | Scoped role definition ID | `string` | `null` | no* |
| `principal_id` | ID of the principal to assign the role to | `string` | - | yes |
| `principal_type` | Type: User, Group, ServicePrincipal, ForeignGroup, Device | `string` | `null` | no |
| `condition` | ABAC condition expression | `string` | `null` | no |
| `condition_version` | Condition syntax version: "1.0" or "2.0" | `string` | `null` | no |
| `description` | Description for the assignment | `string` | `null` | no |
| `skip_service_principal_aad_check` | Skip AAD check for service principals | `bool` | `false` | no |
| `delegated_managed_identity_resource_id` | Delegated managed identity resource ID | `string` | `null` | no |
| `name` | Custom UUID for the assignment | `string` | `null` | no |

> \* One of `role_definition_name` or `role_definition_id` must be specified.

## Outputs

| Name | Description |
|------|-------------|
| `role_assignment_ids` | Map of role assignment keys to their resource IDs |
| `role_assignment_names` | Map of role assignment keys to their names (UUIDs) |
| `role_assignment_principal_types` | Map of role assignment keys to the resolved principal type |
| `role_assignments` | Full map of all role assignment resources |

## Dependencies

- **Scope resource** must exist before assigning a role to it
- **Principal** (User, Group, Service Principal) must exist in Azure AD
- **Role Definition** must exist (built-in roles are always available; custom roles must be created first)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0, < 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the role assignment. | `bool` | `true` | no |
| <a name="input_resource_group_role_assignments"></a> [resource\_group\_role\_assignments](#input\_resource\_group\_role\_assignments) | (Optional) Map of role assignments scoped to a specific Resource Group. Key is a unique identifier.<br/>- resource\_group\_id: (Required) The Resource Group ID as scope. DEPENDENCY: Resource Group must exist.<br/>- role\_definition\_name: (Optional) Built-in role name. Conflicts with role\_definition\_id.<br/>- role\_definition\_id: (Optional) Scoped role definition ID. Conflicts with role\_definition\_name.<br/>- principal\_id: (Required) The principal ID. DEPENDENCY: Principal must exist.<br/>- principal\_type: (Optional) Type of principal.<br/>- description: (Optional) Description for the assignment.<br/>- skip\_service\_principal\_aad\_check: (Optional) Skip AAD check. Defaults to false. | <pre>map(object({<br/>    resource_group_id                = string<br/>    role_definition_name             = optional(string, null)<br/>    role_definition_id               = optional(string, null)<br/>    principal_id                     = string<br/>    principal_type                   = optional(string, null)<br/>    description                      = optional(string, null)<br/>    skip_service_principal_aad_check = optional(bool, false)<br/>  }))</pre> | `{}` | no |
| <a name="input_role_assignments"></a> [role\_assignments](#input\_role\_assignments) | (Optional) List of role assignments to create. Each object supports:<br/>- scope: (Required) The scope at which the Role Assignment applies (Management Group, Subscription, Resource Group, or Resource ID). DEPENDENCY: Scope resource must exist.<br/>- role\_definition\_name: (Optional) The name of a built-in Role (e.g., "Contributor", "Reader"). Conflicts with role\_definition\_id.<br/>- role\_definition\_id: (Optional) The Scoped-ID of the Role Definition. Conflicts with role\_definition\_name.<br/>- principal\_id: (Required) The ID of the Principal (User, Group, or Service Principal) to assign the Role Definition to. DEPENDENCY: Principal must exist in Azure AD.<br/>- principal\_type: (Optional) The type of the principal\_id. Possible values: User, Group, ServicePrincipal, ForeignGroup, Device. Setting this avoids a silent API lookup.<br/>- condition: (Optional) The condition that limits the resources that the role can be assigned to.<br/>- condition\_version: (Optional) The version of the condition syntax. Required if condition is set. Values: "1.0", "2.0".<br/>- description: (Optional) The description for this Role Assignment.<br/>- skip\_service\_principal\_aad\_check: (Optional) Skip the Azure AD check for service principals. Defaults to false.<br/>- delegated\_managed\_identity\_resource\_id: (Optional) The delegated Azure Resource ID which contains a Managed Identity.<br/>- name: (Optional) A UUID for the Role Assignment. A new UUID will be generated if not provided. | <pre>list(object({<br/>    scope                                  = string<br/>    role_definition_name                   = optional(string, null)<br/>    role_definition_id                     = optional(string, null)<br/>    principal_id                           = string<br/>    principal_type                         = optional(string, null)<br/>    condition                              = optional(string, null)<br/>    condition_version                      = optional(string, null)<br/>    description                            = optional(string, null)<br/>    skip_service_principal_aad_check       = optional(bool, false)<br/>    delegated_managed_identity_resource_id = optional(string, null)<br/>    name                                   = optional(string, null)<br/>  }))</pre> | `[]` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | (Optional) The Subscription ID to use as scope. Conflicts with scope in role\_assignments. | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_role_assignment_ids"></a> [role\_assignment\_ids](#output\_role\_assignment\_ids) | Map of role assignment keys to their resource IDs. |
| <a name="output_role_assignment_names"></a> [role\_assignment\_names](#output\_role\_assignment\_names) | Map of role assignment keys to their names (UUIDs). |
| <a name="output_role_assignment_principal_types"></a> [role\_assignment\_principal\_types](#output\_role\_assignment\_principal\_types) | Map of role assignment keys to the resolved principal type. |
| <a name="output_role_assignments"></a> [role\_assignments](#output\_role\_assignments) | Full map of all role assignment resources. |
<!-- END_TF_DOCS -->