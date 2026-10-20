<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_virtual_machine_data_disk_attachment.virtual_machine_data_disk_attachment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_caching"></a> [caching](#input\_caching) | value to set the caching | `string` | n/a | yes |
| <a name="input_create_option"></a> [create\_option](#input\_create\_option) | value to set the create option | `string` | `null` | no |
| <a name="input_lun"></a> [lun](#input\_lun) | value to set the lun | `number` | n/a | yes |
| <a name="input_managed_disk_id"></a> [managed\_disk\_id](#input\_managed\_disk\_id) | value to set the managed disk id | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_virtual_machine_id"></a> [virtual\_machine\_id](#input\_virtual\_machine\_id) | value to set the virtual machine id | `string` | n/a | yes |
| <a name="input_write_accelerator_enabled"></a> [write\_accelerator\_enabled](#input\_write\_accelerator\_enabled) | value to set the write accelerator enabled | `bool` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT VIRTUAL MACHINE DATA DISK ATTACHMENT ############################################################################ |
<!-- END_TF_DOCS -->