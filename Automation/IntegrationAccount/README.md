# Azure Logic App Integration Account Module

Terraform module to create and manage **Azure Logic App Integration Accounts** for B2B enterprise integrations.

## Features

- Free, Basic, and Standard SKUs
- Integration Service Environment (ISE) support
- Foundation for B2B components (schemas, maps, partners, agreements)
- Link to Logic Apps for B2B workflows
- Conditional creation with `create = true/false`

## Usage - Basic

```hcl
module "integration_account" {
  source = "path/to/Automation/IntegrationAccount"

  resource_group_name = "rg-automation-dev-001"
  location            = "westeurope"
  name                = "intacc-b2b-dev-001"
  sku_name            = "Basic"

  tags = {
    Environment = "Development"
  }
}
```

## Usage - Standard SKU

```hcl
module "integration_account" {
  source = "path/to/Automation/IntegrationAccount"

  resource_group_name = "rg-automation-prod-001"
  location            = "westeurope"
  name                = "intacc-b2b-prod-001"
  sku_name            = "Standard"

  tags = {
    Environment = "Production"
    Purpose     = "B2B Integration"
  }
}
```

## Usage - With Logic App

```hcl
module "integration_account" {
  source = "path/to/Automation/IntegrationAccount"

  resource_group_name = "rg-automation-prod-001"
  location            = "westeurope"
  name                = "intacc-edi-prod-001"
  sku_name            = "Standard"

  tags = {
    Environment = "Production"
  }
}

# Link to Logic App
module "logic_app" {
  source = "../LogicApp"

  resource_group_name              = "rg-automation-prod-001"
  location                         = "westeurope"
  name                             = "logic-edi-process-prod-001"
  logic_app_integration_account_id = module.integration_account.id

  identity = {
    type = "SystemAssigned"
  }
}
```

## SKU Comparison

| Feature | Free | Basic | Standard |
|---------|------|-------|----------|
| Schemas | 500 KB total | 8 MB each, 8 MB total | 8 MB each, 8 MB total |
| Maps | 500 KB total | 2 MB each | 2 MB each |
| Partners | 25 | Unlimited | Unlimited |
| Agreements | 10 | Unlimited | Unlimited |
| Certificates | - | Unlimited | Unlimited |
| Batch configurations | - | - | Unlimited |
| RosettaNet | - | - | ✓ |
| AS2 tracking | - | - | ✓ |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create` | Controls whether to create the resource | `bool` | `true` | no |
| `resource_group_name` | Name of the Resource Group | `string` | - | yes |
| `location` | Azure Region | `string` | - | yes |
| `name` | Explicit name | `string` | `null` | no |
| `name_prefix` | Prefix for generated name | `string` | `"intacc"` | no |
| `workload` | Workload name | `string` | `"b2b"` | no |
| `environment` | Environment name | `string` | `"dev"` | no |
| `instance` | Instance number | `string` | `"001"` | no |
| `sku_name` | SKU: Free, Basic, Standard | `string` | `"Basic"` | no |
| `integration_service_environment_id` | ISE ID | `string` | `null` | no |
| `tags` | Tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The ID of the Integration Account |
| `name` | The name |
| `sku_name` | The SKU |

## Dependencies

- **Resource Group** must exist
- **ISE** must exist if `integration_service_environment_id` is specified

## B2B Components

After creating an Integration Account, you can add B2B components:

- **Schemas** - XML schemas for message validation
- **Maps** - XSLT transforms
- **Partners** - Trading partners
- **Agreements** - AS2, X12, EDIFACT agreements
- **Certificates** - Public/private certificates for signing/encryption
- **Batch Configurations** - Batch processing rules

These are typically managed via separate Terraform resources or the Azure Portal.

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
| [azurerm_logic_app_integration_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_integration_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Integration Account. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number for the naming convention. | `string` | `"001"` | no |
| <a name="input_integration_service_environment_id"></a> [integration\_service\_environment\_id](#input\_integration\_service\_environment\_id) | (Optional) The ID of the Integration Service Environment. DEPENDENCY: ISE must exist. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Integration Account should exist. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the Integration Account. If not provided, a name will be generated. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for the generated name. Default: 'intacc'. | `string` | `"intacc"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | (Optional) The SKU of the Integration Account. Possible values: Free, Basic, Standard. Default: Basic. | `string` | `"Basic"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for the naming convention. | `string` | `"b2b"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Integration Account. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Integration Account. |
| <a name="output_sku_name"></a> [sku\_name](#output\_sku\_name) | The SKU of the Integration Account. |
<!-- END_TF_DOCS -->