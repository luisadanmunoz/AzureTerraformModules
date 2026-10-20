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
