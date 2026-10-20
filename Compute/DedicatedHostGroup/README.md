# DedicatedHostGroup

Terraform module for creating Azure Dedicated Host Groups.

## Features

- Fault domain configuration
- Availability Zone placement
- Automatic VM placement
- Conditional creation

## Usage

```hcl
module "host_group" {
  source = "./Compute/DedicatedHostGroup"

  resource_group_name = "rg-compute-prod-001"
  location            = "westeurope"

  workload    = "sap"
  environment = "prod"

  platform_fault_domain_count = 2
  zone                        = "1"
  automatic_placement_enabled = true
}

# Then add hosts
module "host" {
  source = "./Compute/DedicatedHost"
  dedicated_host_group_id = module.host_group.id
  sku_name                = "DSv3-Type1"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Resource Group | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| platform_fault_domain_count | Fault domains (1-3) | `number` | n/a | yes |
| zone | Availability Zone | `string` | `null` | no |
| automatic_placement_enabled | Auto place VMs | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Host Group ID |
| name | Host Group name |

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
| [azurerm_dedicated_host_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dedicated_host_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_automatic_placement_enabled"></a> [automatic\_placement\_enabled](#input\_automatic\_placement\_enabled) | (Optional) Enable automatic VM placement. Default: true. | `bool` | `true` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Dedicated Host Group. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number for the naming convention. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Host Group should exist. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the Dedicated Host Group. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for the generated name. Default: 'dhg'. | `string` | `"dhg"` | no |
| <a name="input_platform_fault_domain_count"></a> [platform\_fault\_domain\_count](#input\_platform\_fault\_domain\_count) | (Required) Number of fault domains. Usually 1, 2, or 3. | `number` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for the naming convention. | `string` | `"host"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | (Optional) The Availability Zone for the Host Group. | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Dedicated Host Group. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Dedicated Host Group. |
| <a name="output_platform_fault_domain_count"></a> [platform\_fault\_domain\_count](#output\_platform\_fault\_domain\_count) | The number of fault domains. |
| <a name="output_zone"></a> [zone](#output\_zone) | The Availability Zone. |
<!-- END_TF_DOCS -->