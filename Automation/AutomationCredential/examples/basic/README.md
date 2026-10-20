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
| <a name="module_automation_credentials"></a> [automation\_credentials](#module\_automation\_credentials) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_automation_account.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_account) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_sql_admin_password"></a> [sql\_admin\_password](#input\_sql\_admin\_password) | SQL Admin password | `string` | `"P@ssw0rd123!"` | no |
| <a name="input_vm_admin_password"></a> [vm\_admin\_password](#input\_vm\_admin\_password) | VM Admin password | `string` | `"P@ssw0rd456!"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_credential_ids"></a> [credential\_ids](#output\_credential\_ids) | Map of credential names to IDs |
| <a name="output_credential_names"></a> [credential\_names](#output\_credential\_names) | List of credential names |
<!-- END_TF_DOCS -->