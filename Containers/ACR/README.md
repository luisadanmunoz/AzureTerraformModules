# ACR (Azure Container Registry)

Terraform module for Azure Container Registry with Premium features support.

## Features

- Basic, Standard, and Premium SKUs
- Geo-replication (Premium)
- Network rules and private endpoints (Premium)
- Customer-managed key encryption (Premium)
- Content trust policy (Premium)
- Retention policy for untagged manifests
- Webhooks for CI/CD integration
- Scope maps for fine-grained access control

## Usage

### Basic Registry

```hcl
module "acr" {
  source = "./Containers/ACR"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "myapp"
  environment = "dev"

  sku = "Standard"
}
```

### Premium with Geo-replication

```hcl
module "acr" {
  source = "./Containers/ACR"

  resource_group_name = azurerm_resource_group.main.name
  location            = "westeurope"

  workload    = "enterprise"
  environment = "prod"

  sku                       = "Premium"
  zone_redundancy_enabled   = true
  data_endpoint_enabled     = true

  georeplications = [
    {
      location                  = "northeurope"
      zone_redundancy_enabled   = true
      regional_endpoint_enabled = true
    },
    {
      location                  = "eastus"
      zone_redundancy_enabled   = true
      regional_endpoint_enabled = true
    }
  ]

  retention_policy = {
    days    = 30
    enabled = true
  }

  trust_policy = {
    enabled = true
  }
}
```

### With Network Rules

```hcl
module "acr" {
  source = "./Containers/ACR"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "secure"
  environment = "prod"

  sku                           = "Premium"
  public_network_access_enabled = true

  network_rule_set = {
    default_action = "Deny"
    ip_rules = [
      {
        ip_range = "203.0.113.0/24"
      }
    ]
    virtual_network_rules = [
      {
        subnet_id = azurerm_subnet.aks.id
      }
    ]
  }

  identity = {
    type = "SystemAssigned"
  }
}
```

### With CMK Encryption

```hcl
module "acr" {
  source = "./Containers/ACR"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "encrypted"
  environment = "prod"

  sku = "Premium"

  identity = {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.acr.id]
  }

  encryption = {
    key_vault_key_id   = azurerm_key_vault_key.acr.id
    identity_client_id = azurerm_user_assigned_identity.acr.client_id
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Resource group name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| name | Registry name (alphanumeric) | `string` | `null` | no |
| workload | Workload name for naming | `string` | `""` | no |
| environment | Environment name | `string` | `""` | no |
| sku | SKU (Basic, Standard, Premium) | `string` | `"Standard"` | no |
| admin_enabled | Enable admin user | `bool` | `false` | no |
| public_network_access_enabled | Allow public access | `bool` | `true` | no |
| zone_redundancy_enabled | Enable zone redundancy | `bool` | `false` | no |
| georeplications | Geo-replication config | `list(object)` | `[]` | no |
| network_rule_set | Network rules | `object` | `null` | no |
| retention_policy | Retention policy config | `object` | `null` | no |
| trust_policy | Content trust config | `object` | `null` | no |
| encryption | CMK encryption config | `object` | `null` | no |
| identity | Managed identity config | `object` | `null` | no |
| webhooks | Webhooks list | `list(object)` | `[]` | no |
| scope_maps | Scope maps list | `list(object)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Container Registry ID |
| name | Container Registry name |
| login_server | Login server URL |
| admin_username | Admin username (if enabled) |
| admin_password | Admin password (if enabled) |
| identity | Identity configuration |
| principal_id | System assigned identity principal ID |
| webhook_ids | Map of webhook IDs |
| scope_map_ids | Map of scope map IDs |

## SKU Comparison

| Feature | Basic | Standard | Premium |
|---------|-------|----------|---------|
| Storage | 10 GB | 100 GB | 500 GB |
| Geo-replication | No | No | Yes |
| Network Rules | No | No | Yes |
| Content Trust | No | No | Yes |
| CMK Encryption | No | No | Yes |
| Zone Redundancy | No | No | Yes |
| Private Link | No | No | Yes |

## Notes

- Registry names must be globally unique and alphanumeric only
- Admin user should be disabled for production (use service principals or managed identities)
- Premium SKU required for enterprise features
- Consider using Private Endpoints for production workloads

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
| [azurerm_container_registry.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_container_registry_scope_map.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry_scope_map) | resource |
| [azurerm_container_registry_webhook.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry_webhook) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_admin_enabled"></a> [admin\_enabled](#input\_admin\_enabled) | Specifies whether the admin user is enabled. Disabled by default for security. | `bool` | `false` | no |
| <a name="input_anonymous_pull_enabled"></a> [anonymous\_pull\_enabled](#input\_anonymous\_pull\_enabled) | Whether allows anonymous (unauthenticated) pull access to the registry. | `bool` | `false` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_data_endpoint_enabled"></a> [data\_endpoint\_enabled](#input\_data\_endpoint\_enabled) | Whether to enable dedicated data endpoints for the Container Registry. Only available for Premium SKU. | `bool` | `false` | no |
| <a name="input_encryption"></a> [encryption](#input\_encryption) | Customer managed key encryption configuration. Only available for Premium SKU. | <pre>object({<br/>    enabled            = optional(bool, true)<br/>    key_vault_key_id   = string<br/>    identity_client_id = string<br/>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name (dev, staging, prod) for naming convention. | `string` | `""` | no |
| <a name="input_export_policy_enabled"></a> [export\_policy\_enabled](#input\_export\_policy\_enabled) | Whether export policy is enabled. Only available for Premium SKU when public access is disabled. | `bool` | `true` | no |
| <a name="input_georeplications"></a> [georeplications](#input\_georeplications) | List of geo-replications for the Container Registry. Only available for Premium SKU. | <pre>list(object({<br/>    location                  = string<br/>    regional_endpoint_enabled = optional(bool, false)<br/>    zone_redundancy_enabled   = optional(bool, false)<br/>    tags                      = optional(map(string), {})<br/>  }))</pre> | `[]` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | Managed identity configuration for the Container Registry. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | The instance identifier for naming convention. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the Container Registry will be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Container Registry. If not provided, will be generated from naming variables. Must be globally unique, alphanumeric only. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for the Container Registry name (alphanumeric only). | `string` | `"cr"` | no |
| <a name="input_network_rule_bypass_option"></a> [network\_rule\_bypass\_option](#input\_network\_rule\_bypass\_option) | Whether to allow trusted Azure services to access the Container Registry. Values are None or AzureServices. | `string` | `"AzureServices"` | no |
| <a name="input_network_rule_set"></a> [network\_rule\_set](#input\_network\_rule\_set) | Network rule set for the Container Registry. Only available for Premium SKU. | <pre>object({<br/>    default_action = optional(string, "Deny")<br/>    ip_rules = optional(list(object({<br/>      action   = optional(string, "Allow")<br/>      ip_range = string<br/>    })), [])<br/>    virtual_network_rules = optional(list(object({<br/>      action    = optional(string, "Allow")<br/>      subnet_id = string<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is allowed for the Container Registry. | `bool` | `true` | no |
| <a name="input_quarantine_policy_enabled"></a> [quarantine\_policy\_enabled](#input\_quarantine\_policy\_enabled) | Whether quarantine policy is enabled. Only available for Premium SKU. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the Container Registry will be created. | `string` | n/a | yes |
| <a name="input_retention_policy"></a> [retention\_policy](#input\_retention\_policy) | Retention policy for untagged manifests. Only available for Premium SKU. | <pre>object({<br/>    days    = optional(number, 7)<br/>    enabled = optional(bool, true)<br/>  })</pre> | `null` | no |
| <a name="input_scope_maps"></a> [scope\_maps](#input\_scope\_maps) | List of scope maps to create for the Container Registry. | <pre>list(object({<br/>    name        = string<br/>    description = optional(string)<br/>    actions     = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU name of the Container Registry. Possible values are Basic, Standard, and Premium. | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources. | `map(string)` | `{}` | no |
| <a name="input_trust_policy"></a> [trust\_policy](#input\_trust\_policy) | Content trust policy for the Container Registry. Only available for Premium SKU. | <pre>object({<br/>    enabled = optional(bool, true)<br/>  })</pre> | `null` | no |
| <a name="input_webhooks"></a> [webhooks](#input\_webhooks) | List of webhooks to create for the Container Registry. | <pre>list(object({<br/>    name        = string<br/>    service_uri = string<br/>    status      = optional(string, "enabled")<br/>    scope       = optional(string, "")<br/>    actions     = optional(list(string), ["push"])<br/>    custom_headers = optional(map(string), {})<br/>  }))</pre> | `[]` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name for naming convention (alphanumeric only). | `string` | `""` | no |
| <a name="input_zone_redundancy_enabled"></a> [zone\_redundancy\_enabled](#input\_zone\_redundancy\_enabled) | Whether zone redundancy is enabled. Only available for Premium SKU. | `bool` | `false` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | The admin password of the Container Registry (if admin is enabled). |
| <a name="output_admin_username"></a> [admin\_username](#output\_admin\_username) | The admin username of the Container Registry (if admin is enabled). |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Container Registry. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity configuration of the Container Registry. |
| <a name="output_login_server"></a> [login\_server](#output\_login\_server) | The URL that can be used to log into the Container Registry. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Container Registry. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The principal ID of the system assigned identity (if enabled). |
| <a name="output_scope_map_ids"></a> [scope\_map\_ids](#output\_scope\_map\_ids) | Map of scope map names to their IDs. |
| <a name="output_webhook_ids"></a> [webhook\_ids](#output\_webhook\_ids) | Map of webhook names to their IDs. |
<!-- END_TF_DOCS -->