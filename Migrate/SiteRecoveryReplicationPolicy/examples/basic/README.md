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

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_replication_policy_extended"></a> [replication\_policy\_extended](#module\_replication\_policy\_extended) | ../../ | n/a |
| <a name="module_replication_policy_standard"></a> [replication\_policy\_standard](#module\_replication\_policy\_standard) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_recovery_services_vault.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/recovery_services_vault) | resource |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_extended_policy_id"></a> [extended\_policy\_id](#output\_extended\_policy\_id) | The ID of the extended replication policy. |
| <a name="output_standard_policy_id"></a> [standard\_policy\_id](#output\_standard\_policy\_id) | The ID of the standard replication policy. |
<!-- END_TF_DOCS -->