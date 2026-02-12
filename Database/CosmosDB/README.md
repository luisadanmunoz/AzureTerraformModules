# Azure Cosmos DB Account Terraform Module

This Terraform module creates an Azure Cosmos DB Account with comprehensive configuration options for consistency policies, geo-replication, networking, backup strategies, and more.

## Features

- Support for multiple Cosmos DB APIs (SQL, MongoDB, Cassandra, Gremlin, Table)
- Configurable consistency policies
- Multi-region geo-replication with automatic failover
- Virtual network integration and IP firewall rules
- Continuous or periodic backup options
- Customer-managed key encryption (CMK)
- Managed identity support
- CORS configuration for web applications
- Free tier support

## Usage

### Basic SQL API Example

```hcl
module "cosmosdb" {
  source = "path/to/CosmosDB"

  resource_group_name = azurerm_resource_group.example.name
  location            = "eastus"
  name                = "cosmos-myapp-prod-001"

  consistency_policy = {
    consistency_level = "Session"
  }

  tags = {
    Environment = "Production"
    Application = "MyApp"
  }
}
```

### MongoDB API Example

```hcl
module "cosmosdb_mongodb" {
  source = "path/to/CosmosDB"

  resource_group_name = azurerm_resource_group.example.name
  location            = "eastus"
  name                = "cosmos-mongodb-prod-001"

  kind                 = "MongoDB"
  mongo_server_version = "4.2"

  capabilities = ["EnableMongo"]

  consistency_policy = {
    consistency_level = "Session"
  }

  backup = {
    type               = "Continuous"
    tier               = "Continuous7Days"
    storage_redundancy = "Geo"
  }

  tags = {
    Environment = "Production"
    API         = "MongoDB"
  }
}
```

### Multi-Region with Automatic Failover

```hcl
module "cosmosdb_multi_region" {
  source = "path/to/CosmosDB"

  resource_group_name = azurerm_resource_group.example.name
  location            = "eastus"
  name                = "cosmos-global-prod-001"

  enable_automatic_failover       = true
  enable_multiple_write_locations = true

  geo_locations = [
    {
      location          = "eastus"
      failover_priority = 0
      zone_redundant    = true
    },
    {
      location          = "westus"
      failover_priority = 1
      zone_redundant    = true
    },
    {
      location          = "westeurope"
      failover_priority = 2
      zone_redundant    = false
    }
  ]

  consistency_policy = {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  backup = {
    type                = "Periodic"
    interval_in_minutes = 240
    retention_in_hours  = 720
    storage_redundancy  = "Geo"
  }

  tags = {
    Environment = "Production"
    Tier        = "Global"
  }
}
```

### With Virtual Network Integration

```hcl
module "cosmosdb_vnet" {
  source = "path/to/CosmosDB"

  resource_group_name = azurerm_resource_group.example.name
  location            = "eastus"
  name                = "cosmos-secure-prod-001"

  public_network_access_enabled     = false
  is_virtual_network_filter_enabled = true

  virtual_network_rules = [
    {
      id                                   = azurerm_subnet.app.id
      ignore_missing_vnet_service_endpoint = false
    },
    {
      id                                   = azurerm_subnet.api.id
      ignore_missing_vnet_service_endpoint = false
    }
  ]

  ip_range_filter = "10.0.0.0/24,192.168.1.0/24"

  consistency_policy = {
    consistency_level = "Strong"
  }

  tags = {
    Environment = "Production"
    Security    = "High"
  }
}
```

### Serverless Configuration

```hcl
module "cosmosdb_serverless" {
  source = "path/to/CosmosDB"

  resource_group_name = azurerm_resource_group.example.name
  location            = "eastus"
  name                = "cosmos-serverless-dev-001"

  capabilities = ["EnableServerless"]

  consistency_policy = {
    consistency_level = "Eventual"
  }

  tags = {
    Environment = "Development"
    CostModel   = "Serverless"
  }
}
```

### With Customer-Managed Key and Managed Identity

```hcl
module "cosmosdb_cmk" {
  source = "path/to/CosmosDB"

  resource_group_name = azurerm_resource_group.example.name
  location            = "eastus"
  name                = "cosmos-encrypted-prod-001"

  identity = {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.cosmosdb.id]
  }

  key_vault_key_id = azurerm_key_vault_key.cosmosdb.id

  consistency_policy = {
    consistency_level = "Session"
  }

  tags = {
    Environment = "Production"
    Encryption  = "CMK"
  }
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
| resource_group_name | The name of the resource group where the Cosmos DB account will be created | `string` | n/a | yes |
| location | The Azure region where the Cosmos DB account will be created | `string` | n/a | yes |
| create | Controls whether resources should be created | `bool` | `true` | no |
| name | The exact name for the Cosmos DB account | `string` | `null` | no |
| name_prefix | Prefix for the generated Cosmos DB account name | `string` | `"cosmos"` | no |
| workload | The workload name to include in the generated name | `string` | `null` | no |
| environment | The environment name to include in the generated name | `string` | `null` | no |
| instance | The instance identifier to include in the generated name | `string` | `null` | no |
| tags | A map of tags to assign to the Cosmos DB account | `map(string)` | `{}` | no |
| offer_type | The offer type for the Cosmos DB account | `string` | `"Standard"` | no |
| kind | The kind of Cosmos DB account (GlobalDocumentDB, MongoDB, Parse) | `string` | `"GlobalDocumentDB"` | no |
| mongo_server_version | The MongoDB server version (3.2, 3.6, 4.0, 4.2) | `string` | `null` | no |
| enable_automatic_failover | Enable automatic failover for the Cosmos DB account | `bool` | `false` | no |
| enable_free_tier | Enable free tier pricing | `bool` | `false` | no |
| enable_multiple_write_locations | Enable multiple write locations | `bool` | `false` | no |
| public_network_access_enabled | Whether public network access is allowed | `bool` | `true` | no |
| is_virtual_network_filter_enabled | Enables virtual network filtering | `bool` | `false` | no |
| ip_range_filter | Comma-separated list of IP addresses or CIDR ranges | `string` | `null` | no |
| analytical_storage_enabled | Enable analytical storage capability | `bool` | `false` | no |
| consistency_policy | The consistency policy configuration | `object` | `{consistency_level = "Session"}` | no |
| geo_locations | List of geo locations for the account | `list(object)` | `null` | no |
| capabilities | List of Cosmos DB capabilities to enable | `list(string)` | `null` | no |
| virtual_network_rules | List of virtual network rules | `list(object)` | `null` | no |
| backup | Backup configuration | `object` | `null` | no |
| cors_rules | CORS rules configuration | `object` | `null` | no |
| identity | Identity configuration | `object` | `null` | no |
| key_vault_key_id | Key Vault Key ID for CMK encryption | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Cosmos DB Account |
| name | The name of the Cosmos DB Account |
| endpoint | The endpoint used to connect to the Cosmos DB Account |
| read_endpoints | A list of read endpoints available for the Cosmos DB Account |
| write_endpoints | A list of write endpoints available for the Cosmos DB Account |
| primary_key | The primary key for the Cosmos DB Account (sensitive) |
| secondary_key | The secondary key for the Cosmos DB Account (sensitive) |
| primary_readonly_key | The primary read-only key for the Cosmos DB Account (sensitive) |
| connection_strings | A list of connection strings available for the Cosmos DB Account (sensitive) |

## Consistency Levels

| Level | Description |
|-------|-------------|
| Strong | Guarantees reads return the most recent committed version |
| BoundedStaleness | Guarantees reads lag behind writes by at most K versions or T time |
| Session | Guarantees monotonic reads, writes, and read-your-own-writes within a session |
| ConsistentPrefix | Guarantees reads never see out-of-order writes |
| Eventual | No ordering guarantee for reads |

## Capabilities

| Capability | Description |
|------------|-------------|
| EnableAggregationPipeline | Enables aggregation pipeline for MongoDB API |
| EnableCassandra | Enables Cassandra API |
| EnableGremlin | Enables Gremlin (Graph) API |
| EnableMongo | Enables MongoDB API |
| EnableServerless | Enables serverless capacity mode |
| EnableTable | Enables Table API |
| mongoEnableDocLevelTTL | Enables document-level TTL for MongoDB |
| MongoDBv3.4 | Enables MongoDB 3.4 compatibility |
| DisableRateLimitingResponses | Disables rate limiting responses |

## Notes

- Only one free tier Cosmos DB account is allowed per Azure subscription
- When using BoundedStaleness consistency, `max_interval_in_seconds` and `max_staleness_prefix` are required
- Virtual network subnets must have the `Microsoft.AzureCosmosDB` service endpoint enabled
- For CMK encryption, the Key Vault must have soft delete and purge protection enabled
- Serverless accounts do not support multiple write locations or geo-replication

## License

MIT License
