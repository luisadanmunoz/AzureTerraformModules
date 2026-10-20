# Key Vault

Terraform module for Azure Key Vault.

## Features

- Standard and Premium SKUs
- RBAC or access policy authorization
- Network ACLs with VNet integration
- Purge protection and soft delete
- Certificate contacts
- Deployment and encryption integration

## Usage

### Basic Key Vault with RBAC

```hcl
module "keyvault" {
  source = "./Security/KeyVault"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tenant_id           = data.azurerm_client_config.current.tenant_id

  workload    = "myapp"
  environment = "prod"

  enable_rbac_authorization = true
  purge_protection_enabled  = true
}
```

### Production with Network Restrictions

```hcl
module "keyvault" {
  source = "./Security/KeyVault"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tenant_id           = data.azurerm_client_config.current.tenant_id

  workload    = "secure"
  environment = "prod"

  sku_name                      = "premium"
  enable_rbac_authorization     = true
  purge_protection_enabled      = true
  soft_delete_retention_days    = 90
  public_network_access_enabled = true

  network_acls = {
    bypass                     = "AzureServices"
    default_action             = "Deny"
    ip_rules                   = ["203.0.113.0/24"]
    virtual_network_subnet_ids = [azurerm_subnet.app.id]
  }

  enabled_for_disk_encryption = true
}
```

### With Access Policies

```hcl
module "keyvault" {
  source = "./Security/KeyVault"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tenant_id           = data.azurerm_client_config.current.tenant_id

  workload    = "legacy"
  environment = "prod"

  enable_rbac_authorization = false

  access_policies = [
    {
      object_id          = data.azurerm_client_config.current.object_id
      secret_permissions = ["Get", "List", "Set", "Delete"]
      key_permissions    = ["Get", "List", "Create", "Delete"]
    }
  ]
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
| tenant_id | Azure AD tenant ID | `string` | n/a | yes |
| name | Key Vault name | `string` | `null` | no |
| workload | Workload name | `string` | `""` | no |
| environment | Environment name | `string` | `""` | no |
| sku_name | SKU (standard/premium) | `string` | `"standard"` | no |
| enable_rbac_authorization | Use RBAC | `bool` | `true` | no |
| purge_protection_enabled | Enable purge protection | `bool` | `true` | no |
| soft_delete_retention_days | Retention days | `number` | `90` | no |
| network_acls | Network ACL config | `object` | `null` | no |
| access_policies | Access policies | `list(object)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Key Vault ID |
| name | Key Vault name |
| vault_uri | Key Vault URI |
| tenant_id | Tenant ID |

## Best Practices

1. **Use RBAC** - Prefer RBAC over access policies for better governance
2. **Enable purge protection** - Prevent permanent deletion of secrets
3. **Use Premium for HSM** - Required for HSM-backed keys
4. **Restrict network access** - Use private endpoints or VNet rules
5. **90 day retention** - Maximum retention for compliance
