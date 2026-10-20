# VMExtension-CustomScript

Terraform module for deploying Custom Script Extension on Azure VMs.

## Features

- Linux and Windows support
- Inline commands or script files
- Download scripts from URLs or Storage Blobs
- Managed Identity authentication for private blobs

## Usage

### Inline Command

```hcl
module "custom_script" {
  source = "./Compute/VMExtension-CustomScript"

  virtual_machine_id = module.vm.id
  os_type            = "Linux"

  command_to_execute = "apt-get update && apt-get install -y nginx"
}
```

### Script from URL

```hcl
module "custom_script" {
  source = "./Compute/VMExtension-CustomScript"

  virtual_machine_id = module.vm.id
  os_type            = "Windows"

  file_uris = [
    "https://raw.githubusercontent.com/org/repo/main/setup.ps1"
  ]
  command_to_execute = "powershell -ExecutionPolicy Unrestricted -File setup.ps1"
}
```

### Private Blob with Managed Identity

```hcl
module "custom_script" {
  source = "./Compute/VMExtension-CustomScript"

  virtual_machine_id = module.vm.id
  os_type            = "Linux"

  file_uris = [
    "https://mystorageaccount.blob.core.windows.net/scripts/install.sh"
  ]
  command_to_execute         = "bash install.sh"
  managed_identity_client_id = module.vm.identity[0].principal_id
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| virtual_machine_id | VM ID | `string` | n/a | yes |
| os_type | Linux or Windows | `string` | n/a | yes |
| command_to_execute | Command to run | `string` | `null` | no |
| file_uris | Script URLs | `list(string)` | `[]` | no |
| storage_account_name | Storage account | `string` | `null` | no |
| storage_account_key | Storage key | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Extension ID |
| name | Extension name |

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
| [azurerm_virtual_machine_extension.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_auto_upgrade_minor_version"></a> [auto\_upgrade\_minor\_version](#input\_auto\_upgrade\_minor\_version) | (Optional) Auto upgrade minor version. Default: true. | `bool` | `true` | no |
| <a name="input_automatic_upgrade_enabled"></a> [automatic\_upgrade\_enabled](#input\_automatic\_upgrade\_enabled) | (Optional) Enable automatic upgrade. Default: false. | `bool` | `false` | no |
| <a name="input_command_to_execute"></a> [command\_to\_execute](#input\_command\_to\_execute) | (Optional) Command to execute. For Linux use shell commands, for Windows use PowerShell. | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the extension. | `bool` | `true` | no |
| <a name="input_file_uris"></a> [file\_uris](#input\_file\_uris) | (Optional) List of URIs to download scripts/files from. | `list(string)` | `[]` | no |
| <a name="input_managed_identity_client_id"></a> [managed\_identity\_client\_id](#input\_managed\_identity\_client\_id) | (Optional) Managed Identity client ID for blob access. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) Extension name. Default: CustomScript. | `string` | `"CustomScript"` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | (Required) OS type. Values: Linux, Windows. | `string` | n/a | yes |
| <a name="input_script"></a> [script](#input\_script) | (Optional) Base64-encoded script content. | `string` | `null` | no |
| <a name="input_storage_account_key"></a> [storage\_account\_key](#input\_storage\_account\_key) | (Optional) Storage account key for private blob access. | `string` | `null` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | (Optional) Storage account name for private blob access. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_virtual_machine_id"></a> [virtual\_machine\_id](#input\_virtual\_machine\_id) | (Required) The ID of the Virtual Machine. DEPENDENCY: VM must exist. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the VM Extension. |
| <a name="output_name"></a> [name](#output\_name) | The name of the VM Extension. |
| <a name="output_virtual_machine_id"></a> [virtual\_machine\_id](#output\_virtual\_machine\_id) | The ID of the Virtual Machine. |
<!-- END_TF_DOCS -->