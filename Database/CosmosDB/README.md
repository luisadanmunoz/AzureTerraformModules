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
| [azurerm_cosmosdb_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_analytical_storage_enabled"></a> [analytical\_storage\_enabled](#input\_analytical\_storage\_enabled) | Enable analytical storage capability for the Cosmos DB account | `bool` | `false` | no |
| <a name="input_backup"></a> [backup](#input\_backup) | Backup configuration for the Cosmos DB account | <pre>object({<br/>    type                = string<br/>    interval_in_minutes = optional(number)<br/>    retention_in_hours  = optional(number)<br/>    storage_redundancy  = optional(string)<br/>    tier                = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_capabilities"></a> [capabilities](#input\_capabilities) | List of Cosmos DB capabilities to enable | `list(string)` | `null` | no |
| <a name="input_consistency_policy"></a> [consistency\_policy](#input\_consistency\_policy) | The consistency policy for the Cosmos DB account | <pre>object({<br/>    consistency_level       = string<br/>    max_interval_in_seconds = optional(number)<br/>    max_staleness_prefix    = optional(number)<br/>  })</pre> | <pre>{<br/>  "consistency_level": "Session"<br/>}</pre> | no |
| <a name="input_cors_rules"></a> [cors\_rules](#input\_cors\_rules) | CORS rules configuration for the Cosmos DB account | <pre>object({<br/>    allowed_headers    = list(string)<br/>    allowed_methods    = list(string)<br/>    allowed_origins    = list(string)<br/>    exposed_headers    = list(string)<br/>    max_age_in_seconds = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created | `bool` | `true` | no |
| <a name="input_enable_automatic_failover"></a> [enable\_automatic\_failover](#input\_enable\_automatic\_failover) | Enable automatic failover for the Cosmos DB account | `bool` | `false` | no |
| <a name="input_enable_free_tier"></a> [enable\_free\_tier](#input\_enable\_free\_tier) | Enable free tier pricing for the Cosmos DB account. Only one free tier account is allowed per subscription | `bool` | `false` | no |
| <a name="input_enable_multiple_write_locations"></a> [enable\_multiple\_write\_locations](#input\_enable\_multiple\_write\_locations) | Enable multiple write locations for the Cosmos DB account | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name to include in the generated name (e.g., dev, staging, prod) | `string` | `null` | no |
| <a name="input_geo_locations"></a> [geo\_locations](#input\_geo\_locations) | List of geo locations for the Cosmos DB account. At least one geo location is required | <pre>list(object({<br/>    location          = string<br/>    failover_priority = number<br/>    zone_redundant    = optional(bool, false)<br/>  }))</pre> | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | Identity configuration for the Cosmos DB account | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | The instance identifier to include in the generated name | `string` | `null` | no |
| <a name="input_ip_range_filter"></a> [ip\_range\_filter](#input\_ip\_range\_filter) | Comma-separated list of IP addresses or IP address ranges in CIDR form to allow through the firewall | `string` | `null` | no |
| <a name="input_is_virtual_network_filter_enabled"></a> [is\_virtual\_network\_filter\_enabled](#input\_is\_virtual\_network\_filter\_enabled) | Enables virtual network filtering for the Cosmos DB account | `bool` | `false` | no |
| <a name="input_key_vault_key_id"></a> [key\_vault\_key\_id](#input\_key\_vault\_key\_id) | Key Vault Key ID for customer-managed key encryption | `string` | `null` | no |
| <a name="input_kind"></a> [kind](#input\_kind) | The kind of Cosmos DB account to create | `string` | `"GlobalDocumentDB"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the Cosmos DB account will be created | `string` | n/a | yes |
| <a name="input_mongo_server_version"></a> [mongo\_server\_version](#input\_mongo\_server\_version) | The MongoDB server version. Only applicable when kind is MongoDB | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The exact name for the Cosmos DB account. If provided, overrides generated name from name\_prefix, workload, environment, and instance | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for the generated Cosmos DB account name | `string` | `"cosmos"` | no |
| <a name="input_offer_type"></a> [offer\_type](#input\_offer\_type) | The offer type for the Cosmos DB account | `string` | `"Standard"` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is allowed for the Cosmos DB account | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the Cosmos DB account will be created | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the Cosmos DB account | `map(string)` | `{}` | no |
| <a name="input_virtual_network_rules"></a> [virtual\_network\_rules](#input\_virtual\_network\_rules) | List of virtual network rules for the Cosmos DB account | <pre>list(object({<br/>    id                                   = string<br/>    ignore_missing_vnet_service_endpoint = optional(bool, false)<br/>  }))</pre> | `null` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name to include in the generated name | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_connection_strings"></a> [connection\_strings](#output\_connection\_strings) | A list of connection strings available for the Cosmos DB Account |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The endpoint used to connect to the Cosmos DB Account |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Cosmos DB Account |
| <a name="output_name"></a> [name](#output\_name) | The name of the Cosmos DB Account |
| <a name="output_primary_key"></a> [primary\_key](#output\_primary\_key) | The primary key for the Cosmos DB Account |
| <a name="output_primary_readonly_key"></a> [primary\_readonly\_key](#output\_primary\_readonly\_key) | The primary read-only key for the Cosmos DB Account |
| <a name="output_read_endpoints"></a> [read\_endpoints](#output\_read\_endpoints) | A list of read endpoints available for the Cosmos DB Account |
| <a name="output_secondary_key"></a> [secondary\_key](#output\_secondary\_key) | The secondary key for the Cosmos DB Account |
| <a name="output_write_endpoints"></a> [write\_endpoints](#output\_write\_endpoints) | A list of write endpoints available for the Cosmos DB Account |
<!-- END_TF_DOCS -->