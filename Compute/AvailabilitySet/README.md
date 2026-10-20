# AvailabilitySet

Terraform module for creating Azure Availability Sets.

## Features

- Configurable fault and update domains
- Proximity Placement Group integration
- Managed disk support
- Conditional creation with `create` flag

## Usage

```hcl
module "availability_set" {
  source = "./Compute/AvailabilitySet"

  resource_group_name = "rg-compute-prod-001"
  location            = "westeurope"

  workload    = "web"
  environment = "prod"

  platform_fault_domain_count  = 3
  platform_update_domain_count = 5
}

# Use with VirtualMachine module
module "vm" {
  source = "./Compute/VirtualMachine"

  availability_set_id = module.availability_set.id
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
| name | Availability Set name | `string` | `null` | no |
| platform_fault_domain_count | Fault domains (2-3) | `number` | `2` | no |
| platform_update_domain_count | Update domains (1-20) | `number` | `5` | no |
| proximity_placement_group_id | PPG ID | `string` | `null` | no |
| managed | Use managed disks | `bool` | `true` | no |
| tags | Tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Availability Set ID |
| name | The Availability Set name |
| platform_fault_domain_count | Fault domains |
| platform_update_domain_count | Update domains |

## Notes

- Cannot be used with Availability Zones (use zones directly on VMs instead)
- Max fault domains varies by region (2 or 3)
- VMs must use managed disks when `managed = true`

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
| [azurerm_availability_set.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/availability_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Availability Set. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number for the naming convention. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Availability Set should exist. | `string` | n/a | yes |
| <a name="input_managed"></a> [managed](#input\_managed) | (Optional) Use managed disks for VMs. Default: true. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the Availability Set. If not provided, a name will be generated. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for the generated name. Default: 'avail'. | `string` | `"avail"` | no |
| <a name="input_platform_fault_domain_count"></a> [platform\_fault\_domain\_count](#input\_platform\_fault\_domain\_count) | (Optional) Number of fault domains. Default: 2. Max varies by region (2 or 3). | `number` | `2` | no |
| <a name="input_platform_update_domain_count"></a> [platform\_update\_domain\_count](#input\_platform\_update\_domain\_count) | (Optional) Number of update domains. Default: 5. Range: 1-20. | `number` | `5` | no |
| <a name="input_proximity_placement_group_id"></a> [proximity\_placement\_group\_id](#input\_proximity\_placement\_group\_id) | (Optional) The ID of the Proximity Placement Group. DEPENDENCY: PPG must exist. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for the naming convention. | `string` | `"app"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Availability Set. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Availability Set. |
| <a name="output_platform_fault_domain_count"></a> [platform\_fault\_domain\_count](#output\_platform\_fault\_domain\_count) | The number of fault domains. |
| <a name="output_platform_update_domain_count"></a> [platform\_update\_domain\_count](#output\_platform\_update\_domain\_count) | The number of update domains. |
<!-- END_TF_DOCS -->