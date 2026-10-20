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
