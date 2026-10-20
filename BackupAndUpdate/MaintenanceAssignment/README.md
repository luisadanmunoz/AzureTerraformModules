# MaintenanceAssignment

Terraform module for assigning Azure Maintenance Configurations to resources.

## Features

- Assign maintenance to Virtual Machines
- Assign maintenance to Dedicated Hosts
- Assign maintenance to Virtual Machine Scale Sets
- Dynamic scope assignments with tag-based targeting
- Conditional creation with `create` flag

## Usage

### Assign to Virtual Machine

```hcl
module "vm_maintenance" {
  source = "./BackupAndUpdate/MaintenanceAssignment"

  location                     = "westeurope"
  maintenance_configuration_id = module.patch_config.id
  assignment_type              = "VirtualMachine"
  virtual_machine_id           = azurerm_windows_virtual_machine.example.id
}
```

### Assign to Multiple VMs

```hcl
module "vm_maintenance" {
  source   = "./BackupAndUpdate/MaintenanceAssignment"
  for_each = { for vm in azurerm_windows_virtual_machine.vms : vm.name => vm.id }

  location                     = "westeurope"
  maintenance_configuration_id = module.patch_config.id
  assignment_type              = "VirtualMachine"
  virtual_machine_id           = each.value
}
```

### Dynamic Scope (Tag-based)

```hcl
module "dynamic_maintenance" {
  source = "./BackupAndUpdate/MaintenanceAssignment"

  location                     = "westeurope"
  maintenance_configuration_id = module.patch_config.id
  assignment_type              = "DynamicScope"

  dynamic_scope = {
    name = "production-vms"
    filter = {
      locations  = ["westeurope", "northeurope"]
      os_types   = ["Windows", "Linux"]
      tag_filter = "All"
      tags = [
        {
          tag    = "Environment"
          values = ["Production"]
        }
      ]
    }
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether to create the resource | `bool` | `true` | no |
| location | Azure region | `string` | n/a | yes |
| maintenance_configuration_id | ID of the Maintenance Configuration | `string` | n/a | yes |
| assignment_type | Type of assignment | `string` | n/a | yes |
| virtual_machine_id | ID of the VM (for VM assignments) | `string` | `null` | no |
| dedicated_host_id | ID of Dedicated Host | `string` | `null` | no |
| virtual_machine_scale_set_id | ID of VMSS | `string` | `null` | no |
| dynamic_scope | Dynamic scope configuration | `object` | `null` | no |
| tags | Tags to assign | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Maintenance Assignment |
| assignment_type | The type of assignment |
| maintenance_configuration_id | The associated configuration ID |
| target_resource_id | The target resource ID |

## Assignment Types

| Type | Description | Required Variable |
|------|-------------|-------------------|
| `VirtualMachine` | Single VM | `virtual_machine_id` |
| `DedicatedHost` | Azure Dedicated Host | `dedicated_host_id` |
| `VirtualMachineScaleSet` | VMSS | `virtual_machine_scale_set_id` |
| `DynamicScope` | Tag-based dynamic targeting | `dynamic_scope` |
