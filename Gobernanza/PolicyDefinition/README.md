# Policy Definition

Terraform module for Azure Policy Definition.

## Features

- Custom policy definitions at subscription or management group scope
- Support for policy rules from inline JSON or external files
- Parameter definitions for reusable policies
- Metadata for categorization and versioning

## Usage

### Basic Policy Definition

```hcl
module "policy_require_tags" {
  source = "./Gobernanza/PolicyDefinition"

  name         = "require-cost-center-tag"
  display_name = "Require Cost Center Tag"
  description  = "Ensures all resources have a CostCenter tag"
  mode         = "Indexed"

  policy_rule = jsonencode({
    if = {
      field  = "[concat('tags[', 'CostCenter', ']')]"
      exists = "false"
    }
    then = {
      effect = "deny"
    }
  })
}
```

### Policy with Parameters

```hcl
module "policy_allowed_locations" {
  source = "./Gobernanza/PolicyDefinition"

  name         = "allowed-locations"
  display_name = "Allowed Locations"
  description  = "Restrict resource deployment to specific regions"
  mode         = "Indexed"

  parameters = jsonencode({
    allowedLocations = {
      type = "Array"
      metadata = {
        displayName = "Allowed locations"
        description = "The list of allowed locations for resources"
      }
    }
  })

  policy_rule = jsonencode({
    if = {
      not = {
        field = "location"
        in    = "[parameters('allowedLocations')]"
      }
    }
    then = {
      effect = "deny"
    }
  })
}
```

### Management Group Scope

```hcl
module "policy_enterprise" {
  source = "./Gobernanza/PolicyDefinition"

  name                = "enterprise-naming-convention"
  display_name        = "Enterprise Naming Convention"
  description         = "Enforce naming convention across the organization"
  mode                = "All"
  management_group_id = data.azurerm_management_group.root.id

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field  = "type"
          equals = "Microsoft.Resources/subscriptions/resourceGroups"
        },
        {
          not = {
            field = "name"
            match = "rg-*-???-###"
          }
        }
      ]
    }
    then = {
      effect = "deny"
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
| name | Policy definition name | `string` | n/a | yes |
| display_name | Display name | `string` | n/a | yes |
| policy_type | Policy type (Custom, BuiltIn) | `string` | `"Custom"` | no |
| mode | Policy mode (All, Indexed) | `string` | `"All"` | no |
| description | Description | `string` | `null` | no |
| policy_rule | Policy rule JSON | `string` | `null` | no |
| policy_rule_file | Path to policy rule file | `string` | `null` | no |
| parameters | Parameters JSON | `string` | `null` | no |
| metadata | Metadata JSON | `string` | `null` | no |
| management_group_id | Management group scope | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Policy Definition ID |
| name | Policy Definition name |
| role_definition_ids | Required roles for remediation |

## Policy Modes

| Mode | Description |
|------|-------------|
| All | Evaluate all resource types |
| Indexed | Only evaluate resource types that support tags and location |
| Microsoft.ContainerService.Data | Evaluate Kubernetes resources |
| Microsoft.KeyVault.Data | Evaluate Key Vault resources |

## Policy Effects

| Effect | Description |
|--------|-------------|
| Deny | Block non-compliant resources |
| Audit | Log non-compliant resources |
| Append | Add fields to resources |
| Modify | Modify resource properties |
| DeployIfNotExists | Deploy resources if missing |
| AuditIfNotExists | Audit if related resource missing |
| Disabled | Policy is disabled |
