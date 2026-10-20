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
