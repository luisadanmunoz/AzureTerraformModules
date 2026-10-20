# Policy Set Definition (Initiative)

Terraform module for Azure Policy Set Definition (Initiative).

## Features

- Custom policy initiatives at subscription or management group scope
- Group multiple policies into a single assignable unit
- Policy definition groups for categorization
- Parameter inheritance across policies
- Support for built-in and custom policy definitions

## Usage

### Basic Initiative

```hcl
module "security_initiative" {
  source = "./Gobernanza/PolicySetDefinition"

  name         = "security-baseline"
  display_name = "Security Baseline Initiative"
  description  = "Core security policies for all resources"

  policy_definitions = [
    {
      policy_definition_id = data.azurerm_policy_definition.https_only.id
      reference_id         = "storageHttps"
    },
    {
      policy_definition_id = data.azurerm_policy_definition.tls_version.id
      reference_id         = "tlsVersion"
    }
  ]
}
```

### Initiative with Groups and Parameters

```hcl
module "governance_initiative" {
  source = "./Gobernanza/PolicySetDefinition"

  name         = "governance-baseline"
  display_name = "Governance Baseline"
  description  = "Organization governance policies"

  policy_definition_groups = [
    {
      name         = "Tagging"
      display_name = "Tagging Policies"
      description  = "Policies related to resource tagging"
      category     = "Tags"
    },
    {
      name         = "Locations"
      display_name = "Location Policies"
      description  = "Policies related to allowed locations"
      category     = "General"
    }
  ]

  parameters = jsonencode({
    allowedLocations = {
      type = "Array"
      metadata = {
        displayName = "Allowed Locations"
        description = "Locations where resources can be deployed"
      }
      defaultValue = ["westeurope", "northeurope"]
    }
  })

  policy_definitions = [
    {
      policy_definition_id = data.azurerm_policy_definition.allowed_locations.id
      reference_id         = "allowedLocations"
      policy_group_names   = ["Locations"]
      parameter_values     = jsonencode({
        listOfAllowedLocations = { value = "[parameters('allowedLocations')]" }
      })
    },
    {
      policy_definition_id = data.azurerm_policy_definition.require_tag.id
      reference_id         = "requireCostCenter"
      policy_group_names   = ["Tagging"]
      parameter_values     = jsonencode({
        tagName = { value = "CostCenter" }
      })
    }
  ]
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
| name | Initiative name | `string` | n/a | yes |
| display_name | Display name | `string` | n/a | yes |
| policy_definitions | List of policy definitions | `list(object)` | n/a | yes |
| policy_type | Policy type | `string` | `"Custom"` | no |
| description | Description | `string` | `null` | no |
| parameters | Parameters JSON | `string` | `null` | no |
| metadata | Metadata JSON | `string` | `null` | no |
| policy_definition_groups | Policy groups | `list(object)` | `[]` | no |
| management_group_id | Management group scope | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Policy Set Definition ID |
| name | Initiative name |

## Best Practices

1. **Group related policies** - Use initiatives to bundle security, compliance, or governance policies
2. **Use parameter inheritance** - Define parameters at initiative level for consistent configuration
3. **Organize with groups** - Use policy groups for better categorization and reporting
4. **Apply at management group** - Define initiatives at highest appropriate scope
5. **Version your initiatives** - Use metadata to track versions
