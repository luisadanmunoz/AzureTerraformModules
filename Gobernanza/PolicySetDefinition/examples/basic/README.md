<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_governance_baseline"></a> [governance\_baseline](#module\_governance\_baseline) | ../../ | n/a |
| <a name="module_security_baseline"></a> [security\_baseline](#module\_security\_baseline) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_policy_definition.allowed_locations](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_definition) | data source |
| [azurerm_policy_definition.require_tag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_definition) | data source |
| [azurerm_policy_definition.sql_tls](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_definition) | data source |
| [azurerm_policy_definition.storage_https](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_definition) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_governance_baseline_id"></a> [governance\_baseline\_id](#output\_governance\_baseline\_id) | n/a |
| <a name="output_security_baseline_id"></a> [security\_baseline\_id](#output\_security\_baseline\_id) | n/a |
<!-- END_TF_DOCS -->