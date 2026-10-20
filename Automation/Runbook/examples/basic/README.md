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
| <a name="module_runbook_powershell"></a> [runbook\_powershell](#module\_runbook\_powershell) | ../../ | n/a |
| <a name="module_runbook_python"></a> [runbook\_python](#module\_runbook\_python) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_automation_account.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_account) | resource |
| [azurerm_automation_schedule.daily](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_schedule) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_job_schedule_ids"></a> [job\_schedule\_ids](#output\_job\_schedule\_ids) | n/a |
| <a name="output_powershell_runbook_id"></a> [powershell\_runbook\_id](#output\_powershell\_runbook\_id) | n/a |
| <a name="output_powershell_runbook_name"></a> [powershell\_runbook\_name](#output\_powershell\_runbook\_name) | n/a |
| <a name="output_python_runbook_id"></a> [python\_runbook\_id](#output\_python\_runbook\_id) | n/a |
<!-- END_TF_DOCS -->