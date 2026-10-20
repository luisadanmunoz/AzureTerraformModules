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
| [azurerm_maintenance_assignment_dedicated_host.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/maintenance_assignment_dedicated_host) | resource |
| [azurerm_maintenance_assignment_dynamic_scope.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/maintenance_assignment_dynamic_scope) | resource |
| [azurerm_maintenance_assignment_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/maintenance_assignment_virtual_machine) | resource |
| [azurerm_maintenance_assignment_virtual_machine_scale_set.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/maintenance_assignment_virtual_machine_scale_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_assignment_type"></a> [assignment\_type](#input\_assignment\_type) | (Required) Type of assignment. Values: VirtualMachine, DedicatedHost, VirtualMachineScaleSet, DynamicScope. | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Maintenance Assignment. | `bool` | `true` | no |
| <a name="input_dedicated_host_id"></a> [dedicated\_host\_id](#input\_dedicated\_host\_id) | (Optional) The ID of the Dedicated Host. Required when assignment\_type is DedicatedHost. DEPENDENCY: Dedicated Host must exist. | `string` | `null` | no |
| <a name="input_dynamic_scope"></a> [dynamic\_scope](#input\_dynamic\_scope) | (Optional) Dynamic scope configuration for assignment\_type DynamicScope.<br/>- name: Name of the dynamic scope assignment.<br/>- filter: Filter configuration for targeting resources. | <pre>object({<br/>    name = string<br/>    filter = object({<br/>      locations       = optional(list(string), [])<br/>      os_types        = optional(list(string), [])<br/>      resource_groups = optional(list(string), [])<br/>      resource_types  = optional(list(string), [])<br/>      tag_filter      = optional(string, null)<br/>      tags = optional(list(object({<br/>        tag    = string<br/>        values = list(string)<br/>      })), [])<br/>    })<br/>  })</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Maintenance Assignment should exist. | `string` | n/a | yes |
| <a name="input_maintenance_configuration_id"></a> [maintenance\_configuration\_id](#input\_maintenance\_configuration\_id) | (Required) The ID of the Maintenance Configuration. DEPENDENCY: Maintenance Configuration must exist. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_virtual_machine_id"></a> [virtual\_machine\_id](#input\_virtual\_machine\_id) | (Optional) The ID of the Virtual Machine. Required when assignment\_type is VirtualMachine. DEPENDENCY: VM must exist. | `string` | `null` | no |
| <a name="input_virtual_machine_scale_set_id"></a> [virtual\_machine\_scale\_set\_id](#input\_virtual\_machine\_scale\_set\_id) | (Optional) The ID of the VMSS. Required when assignment\_type is VirtualMachineScaleSet. DEPENDENCY: VMSS must exist. | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_assignment_type"></a> [assignment\_type](#output\_assignment\_type) | The type of the Maintenance Assignment. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Maintenance Assignment. |
| <a name="output_maintenance_configuration_id"></a> [maintenance\_configuration\_id](#output\_maintenance\_configuration\_id) | The ID of the associated Maintenance Configuration. |
| <a name="output_target_resource_id"></a> [target\_resource\_id](#output\_target\_resource\_id) | The ID of the target resource. |
<!-- END_TF_DOCS -->