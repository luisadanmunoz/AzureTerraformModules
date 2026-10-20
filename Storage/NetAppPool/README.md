# Azure NetApp Files Capacity Pool Terraform Module

This Terraform module creates and manages an Azure NetApp Files Capacity Pool with support for different service levels, QoS types, and encryption options.

## Features

- Configurable naming convention or explicit naming
- Support for Standard, Premium, and Ultra service levels
- Configurable QoS type (Auto or Manual)
- Optional encryption type (Single or Double)
- Conditional creation using `create` flag
- Default tags for resource management

## Usage

### Standard Tier Example

```hcl
module "netapp_pool_standard" {
  source = "../../Storage/NetAppPool"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  account_name        = azurerm_netapp_account.example.name

  name          = "pool-standard-001"
  size_in_tb    = 4
  service_level = "Standard"

  tags = {
    Environment = "Development"
    Project     = "MyApp"
  }
}
```

### Premium Tier Example

```hcl
module "netapp_pool_premium" {
  source = "../../Storage/NetAppPool"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  account_name        = azurerm_netapp_account.example.name

  name          = "pool-premium-001"
  size_in_tb    = 4
  service_level = "Premium"
  qos_type      = "Manual"

  tags = {
    Environment = "Production"
    Project     = "HighPerformance"
  }
}
```

### Ultra Tier Example

```hcl
module "netapp_pool_ultra" {
  source = "../../Storage/NetAppPool"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  account_name        = azurerm_netapp_account.example.name

  name            = "pool-ultra-001"
  size_in_tb      = 4
  service_level   = "Ultra"
  qos_type        = "Manual"
  encryption_type = "Double"

  tags = {
    Environment = "Production"
    Project     = "CriticalWorkload"
    Security    = "DoubleEncryption"
  }
}
```

### Using Naming Convention

```hcl
module "netapp_pool" {
  source = "../../Storage/NetAppPool"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  account_name        = azurerm_netapp_account.example.name

  # Uses naming convention: anfpool-myapp-prod-001
  name_prefix = "anfpool"
  workload    = "myapp"
  environment = "prod"
  instance    = "001"

  size_in_tb    = 8
  service_level = "Premium"

  tags = {
    Environment = "Production"
  }
}
```

### Disable Module Creation

```hcl
module "netapp_pool" {
  source = "../../Storage/NetAppPool"

  create = false

  resource_group_name = "rg-placeholder"
  location            = "westeurope"
  account_name        = "anf-placeholder"
  size_in_tb          = 4
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 3.70.0, < 5.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_netapp_pool.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether to create the NetApp Capacity Pool | `bool` | `true` | no |
| resource\_group\_name | The name of the Resource Group (DEPENDENCY) | `string` | n/a | yes |
| location | The Azure region for deployment (DEPENDENCY) | `string` | n/a | yes |
| account\_name | The name of the NetApp Account (DEPENDENCY) | `string` | n/a | yes |
| name | Explicit name for the NetApp Capacity Pool | `string` | `null` | no |
| name\_prefix | Prefix for generated name | `string` | `"anfpool"` | no |
| workload | Workload or application name for naming | `string` | `"shared"` | no |
| environment | Environment name for naming | `string` | `"dev"` | no |
| instance | Instance identifier for naming | `string` | `"001"` | no |
| size\_in\_tb | Size of the Capacity Pool in TiB (minimum 4) | `number` | n/a | yes |
| service\_level | Service level: Standard, Premium, or Ultra | `string` | `"Standard"` | no |
| qos\_type | QoS type: Auto or Manual | `string` | `"Auto"` | no |
| encryption\_type | Encryption type: Single or Double | `string` | `null` | no |
| tags | Map of tags to assign | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the NetApp Capacity Pool |
| name | The name of the NetApp Capacity Pool |
| service\_level | The service level of the NetApp Capacity Pool |
| size\_in\_tb | The size of the NetApp Capacity Pool in TiB |

## Service Level Comparison

| Service Level | Throughput per TiB | Typical Use Case |
|--------------|-------------------|------------------|
| Standard | 16 MiB/s | Development, test workloads, file shares |
| Premium | 64 MiB/s | Production databases, general-purpose workloads |
| Ultra | 128 MiB/s | High-performance computing, latency-sensitive applications |

## Dependencies

Resources that must exist before using this module:

- **Resource Group** - Must exist before creating the NetApp Capacity Pool
- **NetApp Account** - Must exist in the same Resource Group and location

## Notes

- Capacity Pool size must be at least 4 TiB and in increments of 1 TiB
- Once created, the service level cannot be changed without recreating the pool
- QoS type determines how throughput is allocated to volumes within the pool:
  - **Auto**: Throughput is proportionally assigned based on volume quota
  - **Manual**: Throughput is manually set per volume, allowing for flexible allocation
- Encryption type can only be set during pool creation and cannot be changed afterward

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
| [azurerm_netapp_pool.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | (Required) The name of the NetApp Account in which to create the Capacity Pool.<br/>DEPENDENCY: NetApp Account must exist before creating the Capacity Pool. | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the NetApp Capacity Pool. Set to false to disable resource creation without removing module code. | `bool` | `true` | no |
| <a name="input_encryption_type"></a> [encryption\_type](#input\_encryption\_type) | (Optional) The encryption type of the Capacity Pool.<br/>Valid options are Single (single encryption) or Double (double encryption).<br/>If not specified, the platform default will be used. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) The environment name (e.g., dev, staging, prod), used for naming convention. | `string` | `"dev"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number or identifier for naming convention. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure region where the NetApp Capacity Pool will be deployed.<br/>DEPENDENCY: Should match the Resource Group and NetApp Account location. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The explicit name for the NetApp Capacity Pool. If provided, overrides name\_prefix/workload/environment/instance logic. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix to prepend to the generated NetApp Capacity Pool name. Used when 'name' is not provided. Default is 'anfpool'. | `string` | `"anfpool"` | no |
| <a name="input_qos_type"></a> [qos\_type](#input\_qos\_type) | (Optional) The QoS type of the Capacity Pool.<br/>Valid options are Auto (QoS based on volume throughput and size) or Manual (QoS manually set per volume).<br/>Default is Auto. | `string` | `"Auto"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the NetApp Capacity Pool will be created.<br/>DEPENDENCY: Resource Group must exist before creating the NetApp Capacity Pool. | `string` | n/a | yes |
| <a name="input_service_level"></a> [service\_level](#input\_service\_level) | (Optional) The service level of the Capacity Pool.<br/>Valid options are Standard (16 MiB/s per TiB), Premium (64 MiB/s per TiB), or Ultra (128 MiB/s per TiB).<br/>Default is Standard. | `string` | `"Standard"` | no |
| <a name="input_size_in_tb"></a> [size\_in\_tb](#input\_size\_in\_tb) | (Required) Size of the Capacity Pool in TiB.<br/>Minimum value is 4 TiB. Must be in increments of 1 TiB. | `number` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to the NetApp Capacity Pool. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) The workload or application name, used for naming convention. | `string` | `"shared"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the NetApp Capacity Pool. |
| <a name="output_name"></a> [name](#output\_name) | The name of the NetApp Capacity Pool. |
| <a name="output_service_level"></a> [service\_level](#output\_service\_level) | The service level of the NetApp Capacity Pool (Standard, Premium, or Ultra). |
| <a name="output_size_in_tb"></a> [size\_in\_tb](#output\_size\_in\_tb) | The size of the NetApp Capacity Pool in TiB. |
<!-- END_TF_DOCS -->