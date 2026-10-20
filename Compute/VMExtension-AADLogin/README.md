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
