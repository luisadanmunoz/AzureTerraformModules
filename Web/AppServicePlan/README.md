# Azure App Service Plan Terraform Module

This Terraform module creates an Azure App Service Plan (azurerm_service_plan), which defines the compute resources for hosting web applications, function apps, and container apps in Azure.

## Features

- Support for Linux, Windows, and Windows Container plans
- Full SKU support including Free, Shared, Basic, Standard, Premium, and Isolated tiers
- Elastic Premium plans for Azure Functions
- Integration with App Service Environment (ASE)
- Zone redundancy support
- Per-site scaling capability
- Flexible naming with auto-generation support
- Conditional resource creation

## Usage

### Basic Linux Premium Plan

```hcl
module "app_service_plan" {
  source = "./AppServicePlan"

  resource_group_name = "rg-myapp-prod"
  location            = "eastus"

  name_prefix = "asp"
  workload    = "myapp"
  environment = "prod"

  os_type  = "Linux"
  sku_name = "P1v3"

  tags = {
    Application = "MyApp"
    Environment = "Production"
  }
}
```

### Windows Standard Plan

```hcl
module "app_service_plan_windows" {
  source = "./AppServicePlan"

  resource_group_name = "rg-myapp-prod"
  location            = "westus2"

  name        = "asp-myapp-windows-prod"
  os_type     = "Windows"
  sku_name    = "S1"
  worker_count = 2

  tags = {
    Application = "MyApp"
    Platform    = "Windows"
  }
}
```

### Premium Plan with Zone Redundancy

```hcl
module "app_service_plan_zone_redundant" {
  source = "./AppServicePlan"

  resource_group_name = "rg-critical-app"
  location            = "eastus"

  name_prefix = "asp"
  workload    = "criticalapp"
  environment = "prod"

  os_type               = "Linux"
  sku_name              = "P1v3"
  worker_count          = 3
  zone_balancing_enabled = true

  tags = {
    Application = "CriticalApp"
    HighAvailability = "true"
  }
}
```

### Consumption Plan for Azure Functions

```hcl
module "app_service_plan_consumption" {
  source = "./AppServicePlan"

  resource_group_name = "rg-functions"
  location            = "northeurope"

  name_prefix = "asp"
  workload    = "functions"
  environment = "dev"

  os_type  = "Linux"
  sku_name = "Y1"

  tags = {
    Application = "AzureFunctions"
    Tier        = "Consumption"
  }
}
```

### Elastic Premium Plan for Azure Functions

```hcl
module "app_service_plan_elastic" {
  source = "./AppServicePlan"

  resource_group_name = "rg-functions-prod"
  location            = "eastus"

  name_prefix = "asp"
  workload    = "functions"
  environment = "prod"

  os_type                      = "Linux"
  sku_name                     = "EP1"
  maximum_elastic_worker_count = 20

  tags = {
    Application = "AzureFunctions"
    Tier        = "ElasticPremium"
  }
}
```

### Isolated Plan with App Service Environment

```hcl
module "app_service_plan_isolated" {
  source = "./AppServicePlan"

  resource_group_name = "rg-isolated-apps"
  location            = "eastus"

  name_prefix = "asp"
  workload    = "isolated"
  environment = "prod"

  os_type                    = "Linux"
  sku_name                   = "I1v2"
  app_service_environment_id = "/subscriptions/xxx/resourceGroups/rg-ase/providers/Microsoft.Web/hostingEnvironments/ase-prod"

  tags = {
    Application = "IsolatedApp"
    Security    = "High"
  }
}
```

### Per-Site Scaling Enabled

```hcl
module "app_service_plan_per_site" {
  source = "./AppServicePlan"

  resource_group_name = "rg-multi-tenant"
  location            = "westeurope"

  name_prefix = "asp"
  workload    = "multitenant"
  environment = "prod"

  os_type                  = "Linux"
  sku_name                 = "P2v3"
  worker_count             = 5
  per_site_scaling_enabled = true

  tags = {
    Application = "MultiTenantPlatform"
    ScalingMode = "PerSite"
  }
}
```

## SKU Reference

| Tier | SKUs | Description |
|------|------|-------------|
| Free | F1 | Free tier, limited features, shared infrastructure |
| Shared | D1 | Shared tier, basic features |
| Basic | B1, B2, B3 | Development/test, dedicated compute |
| Standard | S1, S2, S3 | Production workloads, auto-scale, staging slots |
| Premium v2 | P1v2, P2v2, P3v2 | Enhanced performance, more memory |
| Premium v3 | P0v3, P1v3, P2v3, P3v3 | Latest gen, zone redundancy support |
| Isolated | I1, I2, I3 | ASE deployment, network isolation |
| Isolated v2 | I1v2, I2v2, I3v2, I4v2, I5v2, I6v2 | Latest ASE, zone redundancy |
| Consumption | Y1 | Azure Functions serverless |
| Elastic Premium | EP1, EP2, EP3 | Azure Functions with pre-warmed instances |
| Workflow Standard | WS1, WS2, WS3 | Logic Apps Standard |

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
| azurerm_service_plan.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether resources should be created. | `bool` | `true` | no |
| resource_group_name | The name of the resource group where the App Service Plan will be created. | `string` | n/a | yes |
| location | The Azure region where the App Service Plan will be created. | `string` | n/a | yes |
| name | The exact name to use for the App Service Plan. If provided, overrides generated name. | `string` | `null` | no |
| name_prefix | Prefix to use for the generated App Service Plan name. | `string` | `"asp"` | no |
| workload | The workload name to include in the generated name. | `string` | `null` | no |
| environment | The environment name to include in the generated name (e.g., dev, staging, prod). | `string` | `null` | no |
| instance | The instance identifier to include in the generated name. | `string` | `null` | no |
| tags | A map of tags to assign to the App Service Plan. | `map(string)` | `{}` | no |
| os_type | The operating system type for the App Service Plan. Valid values are 'Linux', 'Windows', or 'WindowsContainer'. | `string` | n/a | yes |
| sku_name | The SKU name for the App Service Plan. See SKU Reference table for valid values. | `string` | n/a | yes |
| worker_count | The number of workers (instances) to be allocated. Defaults to null for automatic scaling. | `number` | `null` | no |
| maximum_elastic_worker_count | The maximum number of workers to use in an Elastic SKU Plan. Only valid for Elastic Premium (EP) SKUs. | `number` | `null` | no |
| app_service_environment_id | The ID of the App Service Environment to deploy the App Service Plan to. Required for Isolated (I) tier SKUs. | `string` | `null` | no |
| per_site_scaling_enabled | Whether per-site scaling is enabled for the App Service Plan. When enabled, apps can be scaled independently. | `bool` | `false` | no |
| zone_balancing_enabled | Whether zone balancing is enabled for the App Service Plan. Requires Premium v2/v3 or Isolated v2 SKUs in a zone-redundant region. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the App Service Plan. |
| name | The name of the App Service Plan. |
| kind | The kind of the App Service Plan (e.g., 'linux', 'windows', 'elastic', 'functionapp'). |
| reserved | Whether this is a reserved (Linux) App Service Plan. |
| os_type | The operating system type of the App Service Plan. |

## Notes

- Zone balancing requires Premium v2/v3 or Isolated v2 SKUs and a region that supports availability zones
- Isolated SKUs require an App Service Environment
- The `maximum_elastic_worker_count` is only applicable to Elastic Premium (EP) SKUs
- When using consumption (Y1) or elastic premium (EP) SKUs, the plan is designed for Azure Functions
- Per-site scaling allows individual apps to scale independently within the same plan

## License

This module is maintained by the Cloud Infrastructure team.

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
| [azurerm_service_plan.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_app_service_environment_id"></a> [app\_service\_environment\_id](#input\_app\_service\_environment\_id) | The ID of the App Service Environment to deploy the App Service Plan to. Required for Isolated (I) tier SKUs. | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name to include in the generated name (e.g., dev, staging, prod). | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | The instance identifier to include in the generated name. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the App Service Plan will be created. | `string` | n/a | yes |
| <a name="input_maximum_elastic_worker_count"></a> [maximum\_elastic\_worker\_count](#input\_maximum\_elastic\_worker\_count) | The maximum number of workers to use in an Elastic SKU Plan. Only valid for Elastic Premium (EP) SKUs. | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The exact name to use for the App Service Plan. If provided, overrides generated name. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix to use for the generated App Service Plan name. | `string` | `"asp"` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | The operating system type for the App Service Plan. Valid values are 'Linux', 'Windows', or 'WindowsContainer'. | `string` | n/a | yes |
| <a name="input_per_site_scaling_enabled"></a> [per\_site\_scaling\_enabled](#input\_per\_site\_scaling\_enabled) | Whether per-site scaling is enabled for the App Service Plan. When enabled, apps can be scaled independently. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the App Service Plan will be created. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name for the App Service Plan. Common values include B1, B2, B3, S1, S2, S3, P1v2, P2v2, P3v2, P1v3, P2v3, P3v3, P0v3, I1, I2, I3, I1v2, I2v2, I3v2, I4v2, I5v2, I6v2, F1, D1, Y1, EP1, EP2, EP3, WS1, WS2, WS3. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the App Service Plan. | `map(string)` | `{}` | no |
| <a name="input_worker_count"></a> [worker\_count](#input\_worker\_count) | The number of workers (instances) to be allocated. Defaults to null for automatic scaling. | `number` | `null` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name to include in the generated name. | `string` | `null` | no |
| <a name="input_zone_balancing_enabled"></a> [zone\_balancing\_enabled](#input\_zone\_balancing\_enabled) | Whether zone balancing is enabled for the App Service Plan. Requires Premium v2/v3 or Isolated v2 SKUs in a zone-redundant region. | `bool` | `false` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the App Service Plan. |
| <a name="output_kind"></a> [kind](#output\_kind) | The kind of the App Service Plan (e.g., 'linux', 'windows', 'elastic', 'functionapp'). |
| <a name="output_name"></a> [name](#output\_name) | The name of the App Service Plan. |
| <a name="output_os_type"></a> [os\_type](#output\_os\_type) | The operating system type of the App Service Plan. |
| <a name="output_reserved"></a> [reserved](#output\_reserved) | Whether this is a reserved (Linux) App Service Plan. |
<!-- END_TF_DOCS -->