# Azure AI Search Service

Terraform module for creating Azure AI Search (formerly Cognitive Search) services.

## Features

- Full-text search with AI enrichment
- Semantic search support
- Multiple SKUs for different workloads
- Replica and partition scaling
- Private endpoint support

## Usage

```hcl
module "search" {
  source = "path/to/IA/AISearchService"

  name                = "search-prod-001"
  resource_group_name = azurerm_resource_group.ai.name
  location            = "westeurope"
  sku                 = "standard"

  replica_count   = 2
  partition_count = 1

  semantic_search_sku = "standard"

  tags = {
    Environment = "Production"
  }
}
```

## SKU Comparison

| SKU | Replicas | Partitions | Use Case |
|-----|----------|------------|----------|
| free | 1 | 1 | Development |
| basic | 3 | 1 | Small workloads |
| standard | 12 | 12 | Production |
| standard2 | 12 | 12 | Large indexes |
| standard3 | 12 | 12 | Very large indexes |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Service name | `string` | n/a | yes |
| resource_group_name | Resource group | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| sku | SKU tier | `string` | `"standard"` | no |
| replica_count | Number of replicas | `number` | `1` | no |
| partition_count | Number of partitions | `number` | `1` | no |
| semantic_search_sku | Semantic search SKU | `string` | `null` | no |
| public_network_access_enabled | Allow public access | `bool` | `true` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The service ID |
| name | The service name |
| primary_key | Primary admin key (sensitive) |
| secondary_key | Secondary admin key (sensitive) |
| query_keys | Query keys (sensitive) |
| principal_id | System identity principal ID |

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
| [azurerm_search_service.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/search_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_allowed_ips"></a> [allowed\_ips](#input\_allowed\_ips) | List of allowed IP addresses. | `list(string)` | `[]` | no |
| <a name="input_authentication_failure_mode"></a> [authentication\_failure\_mode](#input\_authentication\_failure\_mode) | The failure mode for authentication. Possible values: http401WithBearerChallenge, http403. | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the search service. | `bool` | `true` | no |
| <a name="input_customer_managed_key_enforcement_enabled"></a> [customer\_managed\_key\_enforcement\_enabled](#input\_customer\_managed\_key\_enforcement\_enabled) | Whether customer managed key enforcement is enabled. | `bool` | `false` | no |
| <a name="input_hosting_mode"></a> [hosting\_mode](#input\_hosting\_mode) | The hosting mode. Possible values: default, highDensity. | `string` | `"default"` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The type of managed identity. | `string` | `null` | no |
| <a name="input_local_authentication_enabled"></a> [local\_authentication\_enabled](#input\_local\_authentication\_enabled) | Whether local authentication is enabled. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Search Service. | `string` | n/a | yes |
| <a name="input_partition_count"></a> [partition\_count](#input\_partition\_count) | The number of partitions. | `number` | `1` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is enabled. | `bool` | `true` | no |
| <a name="input_replica_count"></a> [replica\_count](#input\_replica\_count) | The number of replicas. | `number` | `1` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_semantic_search_sku"></a> [semantic\_search\_sku](#input\_semantic\_search\_sku) | The SKU for semantic search. Possible values: free, standard. | `string` | `null` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU. Possible values: free, basic, standard, standard2, standard3, storage\_optimized\_l1, storage\_optimized\_l2. | `string` | `"standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Search Service. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity block. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Search Service. |
| <a name="output_primary_key"></a> [primary\_key](#output\_primary\_key) | The primary admin key. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The principal ID of the system-assigned identity. |
| <a name="output_query_keys"></a> [query\_keys](#output\_query\_keys) | The query keys. |
| <a name="output_secondary_key"></a> [secondary\_key](#output\_secondary\_key) | The secondary admin key. |
<!-- END_TF_DOCS -->