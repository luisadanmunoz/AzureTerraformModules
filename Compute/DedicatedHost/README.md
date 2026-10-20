# DedicatedHost

Terraform module for creating Azure Dedicated Hosts.

## Features

- Various SKU types (DSv3, ESv3, etc.)
- Fault domain placement
- Auto-replace on failure
- Windows Server licensing

## Usage

```hcl
module "dedicated_host" {
  source = "./Compute/DedicatedHost"

  resource_group_name     = "rg-compute-prod-001"
  location                = "westeurope"
  dedicated_host_group_id = module.host_group.id

  workload    = "sap"
  environment = "prod"

  sku_name              = "DSv3-Type1"
  platform_fault_domain = 0
  license_type          = "Windows_Server_Hybrid"
}

# Use with VMs
module "vm" {
  source = "./Compute/VirtualMachine"
  dedicated_host_id = module.dedicated_host.id
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dedicated_host_group_id | Parent Host Group | `string` | n/a | yes |
| sku_name | Host SKU | `string` | n/a | yes |
| platform_fault_domain | Fault domain | `number` | `0` | no |
| auto_replace_on_failure | Auto replace | `bool` | `true` | no |
| license_type | Windows licensing | `string` | `"None"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Dedicated Host ID |
| name | Dedicated Host name |

## Common SKUs

- `DSv3-Type1`, `DSv3-Type2` - D-series
- `ESv3-Type1`, `ESv3-Type2` - E-series
- `FSv2-Type2` - F-series
- `MSv2-Type1` - M-series (memory optimized)

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
| [azurerm_dedicated_host.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dedicated_host) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_auto_replace_on_failure"></a> [auto\_replace\_on\_failure](#input\_auto\_replace\_on\_failure) | (Optional) Auto replace on failure. Default: true. | `bool` | `true` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Dedicated Host. | `bool` | `true` | no |
| <a name="input_dedicated_host_group_id"></a> [dedicated\_host\_group\_id](#input\_dedicated\_host\_group\_id) | (Required) The ID of the Dedicated Host Group. DEPENDENCY: Host Group must exist. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number for the naming convention. | `string` | `"001"` | no |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | (Optional) License type. Values: None, Windows\_Server\_Hybrid, Windows\_Server\_Perpetual. | `string` | `"None"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Host should exist. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the Dedicated Host. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for the generated name. Default: 'dh'. | `string` | `"dh"` | no |
| <a name="input_platform_fault_domain"></a> [platform\_fault\_domain](#input\_platform\_fault\_domain) | (Optional) The fault domain of the host. Default: 0. | `number` | `0` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | (Required) The SKU name of the Dedicated Host (e.g., DSv3-Type1, ESv3-Type1). | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for the naming convention. | `string` | `"host"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_dedicated_host_group_id"></a> [dedicated\_host\_group\_id](#output\_dedicated\_host\_group\_id) | The ID of the parent Host Group. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Dedicated Host. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Dedicated Host. |
| <a name="output_sku_name"></a> [sku\_name](#output\_sku\_name) | The SKU of the Dedicated Host. |
<!-- END_TF_DOCS -->