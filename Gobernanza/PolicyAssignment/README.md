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
| [azurerm_management_group_policy_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment) | resource |
| [azurerm_resource_group_policy_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_assignment) | resource |
| [azurerm_resource_policy_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_policy_assignment) | resource |
| [azurerm_subscription_policy_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment) | resource |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the policy assignment. | `string` | `null` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of the policy assignment. | `string` | `null` | no |
| <a name="input_enforce"></a> [enforce](#input\_enforce) | Whether the policy assignment is enforced. | `bool` | `true` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | Managed identity configuration for remediation tasks. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The location of the policy assignment (required when identity is specified). | `string` | `null` | no |
| <a name="input_management_group_id"></a> [management\_group\_id](#input\_management\_group\_id) | The ID of the Management Group for the assignment (when scope\_type is management\_group). | `string` | `null` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | Metadata for the policy assignment in JSON format. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the policy assignment. | `string` | n/a | yes |
| <a name="input_non_compliance_messages"></a> [non\_compliance\_messages](#input\_non\_compliance\_messages) | List of non-compliance messages for the policy assignment. | <pre>list(object({<br/>    content                        = string<br/>    policy_definition_reference_id = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_not_scopes"></a> [not\_scopes](#input\_not\_scopes) | List of resource IDs to exclude from the policy assignment. | `list(string)` | `[]` | no |
| <a name="input_overrides"></a> [overrides](#input\_overrides) | Policy property value overrides. | <pre>list(object({<br/>    value = string<br/>    selectors = list(object({<br/>      kind   = string<br/>      in     = optional(list(string))<br/>      not_in = optional(list(string))<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | Parameters for the policy assignment in JSON format. | `string` | `null` | no |
| <a name="input_policy_definition_id"></a> [policy\_definition\_id](#input\_policy\_definition\_id) | The ID of the Policy Definition to assign. | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | The ID of the Resource Group for the assignment (when scope\_type is resource\_group). | `string` | `null` | no |
| <a name="input_resource_id"></a> [resource\_id](#input\_resource\_id) | The ID of the Resource for the assignment (when scope\_type is resource). | `string` | `null` | no |
| <a name="input_resource_selectors"></a> [resource\_selectors](#input\_resource\_selectors) | Resource selectors to filter resources for the policy assignment. | <pre>list(object({<br/>    name = string<br/>    selectors = list(object({<br/>      kind   = string<br/>      in     = optional(list(string))<br/>      not_in = optional(list(string))<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_scope_type"></a> [scope\_type](#input\_scope\_type) | The type of scope for the assignment: subscription, resource\_group, management\_group, or resource. | `string` | `"subscription"` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The ID of the Subscription for the assignment (when scope\_type is subscription). If null, uses current subscription. | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Policy Assignment. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity of the Policy Assignment. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Policy Assignment. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The Principal ID of the Policy Assignment's managed identity. |
<!-- END_TF_DOCS -->