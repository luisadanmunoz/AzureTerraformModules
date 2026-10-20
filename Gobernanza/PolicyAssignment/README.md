# Policy Assignment

Terraform module for Azure Policy Assignment.

## Features

- Policy assignment at multiple scopes (subscription, resource group, management group, resource)
- Support for policy parameters
- Managed identity for remediation tasks
- Non-compliance messages
- Resource selectors and overrides
- Exclusion scopes (not_scopes)

## Usage

### Subscription Assignment

```hcl
module "policy_assignment" {
  source = "./Gobernanza/PolicyAssignment"

  name                 = "require-tags-assignment"
  policy_definition_id = module.policy_require_tags.id
  display_name         = "Require Tags on Resources"
  scope_type           = "subscription"

  parameters = jsonencode({
    tagName = {
      value = "CostCenter"
    }
  })
}
```

### Resource Group Assignment

```hcl
module "policy_assignment_rg" {
  source = "./Gobernanza/PolicyAssignment"

  name                 = "allowed-locations-rg"
  policy_definition_id = data.azurerm_policy_definition.allowed_locations.id
  display_name         = "Allowed Locations - Production"
  scope_type           = "resource_group"
  resource_group_id    = azurerm_resource_group.prod.id

  parameters = jsonencode({
    allowedLocations = {
      value = ["westeurope", "northeurope"]
    }
  })

  non_compliance_messages = [
    {
      content = "This resource is not in an allowed location. Please deploy to West Europe or North Europe."
    }
  ]
}
```

### Management Group with Remediation

```hcl
module "policy_assignment_mg" {
  source = "./Gobernanza/PolicyAssignment"

  name                 = "deploy-diagnostic-settings"
  policy_definition_id = data.azurerm_policy_definition.deploy_diag.id
  display_name         = "Deploy Diagnostic Settings"
  scope_type           = "management_group"
  management_group_id  = data.azurerm_management_group.org.id
  location             = "westeurope"

  # Identity required for DeployIfNotExists policies
  identity = {
    type = "SystemAssigned"
  }

  parameters = jsonencode({
    logAnalytics = {
      value = azurerm_log_analytics_workspace.central.id
    }
  })
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Assignment name | `string` | n/a | yes |
| policy_definition_id | Policy definition ID | `string` | n/a | yes |
| display_name | Display name | `string` | `null` | no |
| description | Description | `string` | `null` | no |
| scope_type | Scope type | `string` | `"subscription"` | no |
| resource_group_id | Resource group ID | `string` | `null` | no |
| management_group_id | Management group ID | `string` | `null` | no |
| subscription_id | Subscription ID | `string` | `null` | no |
| resource_id | Resource ID | `string` | `null` | no |
| enforce | Enforce policy | `bool` | `true` | no |
| parameters | Parameters JSON | `string` | `null` | no |
| not_scopes | Exclusion scopes | `list(string)` | `[]` | no |
| identity | Managed identity | `object` | `null` | no |
| location | Location for identity | `string` | `null` | no |
| non_compliance_messages | Non-compliance messages | `list(object)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Policy Assignment ID |
| name | Assignment name |
| identity | Identity configuration |
| principal_id | Identity principal ID |

## Best Practices

1. **Use Management Group scope** - Apply policies at the highest appropriate level
2. **Use exclusions sparingly** - Prefer targeted assignments over broad exclusions
3. **Include non-compliance messages** - Help users understand why resources are blocked
4. **Use SystemAssigned identity** - For DeployIfNotExists and Modify policies
5. **Test with Audit first** - Validate impact before enforcing with Deny
