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
| [azurerm_management_group_policy_set_definition.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_set_definition) | resource |
| [azurerm_policy_set_definition.subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_set_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the policy set definition. | `string` | `null` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of the policy set definition. | `string` | n/a | yes |
| <a name="input_management_group_id"></a> [management\_group\_id](#input\_management\_group\_id) | The ID of the Management Group where this policy set should be defined. If null, will be defined at subscription level. | `string` | `null` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | The metadata JSON string for the policy set definition. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the policy set definition (initiative). | `string` | n/a | yes |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | The parameters JSON string for the policy set definition. | `string` | `null` | no |
| <a name="input_policy_definition_groups"></a> [policy\_definition\_groups](#input\_policy\_definition\_groups) | Policy definition groups for organizing policies within the initiative. | <pre>list(object({<br/>    name                            = string<br/>    display_name                    = optional(string)<br/>    description                     = optional(string)<br/>    category                        = optional(string)<br/>    additional_metadata_resource_id = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_policy_definitions"></a> [policy\_definitions](#input\_policy\_definitions) | List of policy definitions to include in the initiative. | <pre>list(object({<br/>    policy_definition_id = string<br/>    reference_id         = optional(string)<br/>    parameter_values     = optional(string)<br/>    policy_group_names   = optional(list(string))<br/>  }))</pre> | n/a | yes |
| <a name="input_policy_type"></a> [policy\_type](#input\_policy\_type) | The policy type. Possible values are BuiltIn, Custom, NotSpecified, Static. | `string` | `"Custom"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Policy Set Definition. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Policy Set Definition. |
<!-- END_TF_DOCS -->