# VMExtension-AzureMonitorAgent

Terraform module for deploying Azure Monitor Agent on VMs.

## Features

- Linux and Windows support
- Data Collection Rule association
- System or User Assigned Identity authentication
- Automatic extension upgrades

## Usage

```hcl
module "ama" {
  source = "./Compute/VMExtension-AzureMonitorAgent"

  virtual_machine_id      = module.vm.id
  os_type                 = "Linux"
  data_collection_rule_id = azurerm_monitor_data_collection_rule.main.id
}
```

## Requirements

- VM must have a Managed Identity (System or User Assigned)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| virtual_machine_id | VM ID | `string` | n/a | yes |
| os_type | Linux or Windows | `string` | n/a | yes |
| data_collection_rule_id | DCR ID | `string` | `null` | no |
| user_assigned_identity_id | User Identity | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Extension ID |
| dcr_association_id | DCR Association ID |

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
| [azurerm_monitor_data_collection_rule_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_data_collection_rule_association) | resource |
| [azurerm_virtual_machine_extension.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_auto_upgrade_minor_version"></a> [auto\_upgrade\_minor\_version](#input\_auto\_upgrade\_minor\_version) | (Optional) Auto upgrade minor version. Default: true. | `bool` | `true` | no |
| <a name="input_automatic_upgrade_enabled"></a> [automatic\_upgrade\_enabled](#input\_automatic\_upgrade\_enabled) | (Optional) Enable automatic upgrade. Default: true. | `bool` | `true` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the extension. | `bool` | `true` | no |
| <a name="input_data_collection_endpoint_id"></a> [data\_collection\_endpoint\_id](#input\_data\_collection\_endpoint\_id) | (Optional) The ID of the Data Collection Endpoint. DEPENDENCY: DCE must exist. | `string` | `null` | no |
| <a name="input_data_collection_rule_id"></a> [data\_collection\_rule\_id](#input\_data\_collection\_rule\_id) | (Optional) The ID of the Data Collection Rule to associate. DEPENDENCY: DCR must exist. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) Extension name. Default: AzureMonitorAgent. | `string` | `"AzureMonitorAgent"` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | (Required) OS type. Values: Linux, Windows. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_user_assigned_identity_id"></a> [user\_assigned\_identity\_id](#input\_user\_assigned\_identity\_id) | (Optional) User Assigned Identity ID for authentication. | `string` | `null` | no |
| <a name="input_virtual_machine_id"></a> [virtual\_machine\_id](#input\_virtual\_machine\_id) | (Required) The ID of the Virtual Machine. DEPENDENCY: VM must exist. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_dcr_association_id"></a> [dcr\_association\_id](#output\_dcr\_association\_id) | The ID of the Data Collection Rule Association. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the VM Extension. |
| <a name="output_name"></a> [name](#output\_name) | The name of the VM Extension. |
<!-- END_TF_DOCS -->