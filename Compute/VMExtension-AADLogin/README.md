# VMExtension-AADLogin

Terraform module for enabling Azure AD login on VMs.

## Features

- Linux SSH login with Azure AD (AADSSHLoginForLinux)
- Windows RDP login with Azure AD (AADLoginForWindows)
- No local passwords needed

## Usage

```hcl
module "aad_login" {
  source = "./Compute/VMExtension-AADLogin"

  virtual_machine_id = module.vm.id
  os_type            = "Linux"
}
```

## Requirements

- VM must have System Assigned Managed Identity
- Users need RBAC roles:
  - Virtual Machine Administrator Login (admin)
  - Virtual Machine User Login (standard user)

## RBAC Assignment

```hcl
resource "azurerm_role_assignment" "vm_admin" {
  scope              = module.vm.id
  role_definition_name = "Virtual Machine Administrator Login"
  principal_id       = data.azuread_user.admin.object_id
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| virtual_machine_id | VM ID | `string` | n/a | yes |
| os_type | Linux or Windows | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | Extension ID |
| name | Extension name |

## SSH to Linux VM

```bash
az ssh vm -n vm-name -g resource-group
```

## Notes

- Linux: Users must be in the VM or have JIT access
- Windows: Entra ID joined or Hybrid Entra ID joined

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
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the extension. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) Extension name. Default: AADSSHLogin or AADLoginForWindows. | `string` | `null` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | (Required) OS type. Values: Linux, Windows. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_virtual_machine_id"></a> [virtual\_machine\_id](#input\_virtual\_machine\_id) | (Required) The ID of the Virtual Machine. DEPENDENCY: VM must exist. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the VM Extension. |
| <a name="output_name"></a> [name](#output\_name) | The name of the VM Extension. |
| <a name="output_os_type"></a> [os\_type](#output\_os\_type) | The OS type of the VM. |
<!-- END_TF_DOCS -->