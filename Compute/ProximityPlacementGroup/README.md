# ProximityPlacementGroup

Terraform module for creating Azure Proximity Placement Groups.

## Features

- Low-latency VM placement
- Allowed VM sizes filtering
- Zone-specific placement
- Conditional creation

## Usage

```hcl
module "ppg" {
  source = "./Compute/ProximityPlacementGroup"

  resource_group_name = "rg-compute-prod-001"
  location            = "westeurope"

  workload    = "hpc"
  environment = "prod"

  allowed_vm_sizes = ["Standard_D4s_v5", "Standard_D8s_v5"]
  zone             = "1"
}

# Use with VirtualMachine module
module "vm" {
  source = "./Compute/VirtualMachine"

  proximity_placement_group_id = module.ppg.id
  zone                         = "1"
  # ... other VM config
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
| create | Controls creation | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| name | PPG name | `string` | `null` | no |
| allowed_vm_sizes | Allowed VM sizes | `list(string)` | `[]` | no |
| zone | Availability Zone | `string` | `null` | no |
| tags | Tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The PPG ID |
| name | The PPG name |

## Notes

- Use for HPC, SAP, or latency-sensitive workloads
- VMs in PPG are physically closer together
- Consider combining with Availability Sets

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
| [azurerm_proximity_placement_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/proximity_placement_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_allowed_vm_sizes"></a> [allowed\_vm\_sizes](#input\_allowed\_vm\_sizes) | (Optional) List of allowed VM sizes for the PPG. | `list(string)` | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Proximity Placement Group. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number for the naming convention. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the PPG should exist. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the PPG. If not provided, a name will be generated. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for the generated name. Default: 'ppg'. | `string` | `"ppg"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for the naming convention. | `string` | `"app"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | (Optional) The Availability Zone for the PPG. | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Proximity Placement Group. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Proximity Placement Group. |
<!-- END_TF_DOCS -->