# SQLServer (Azure SQL Logical Server)

Terraform module for Azure SQL Logical Server.

## Features

- SQL and Azure AD authentication
- Azure AD-only authentication support
- TLS 1.2 by default (security best practice)
- Firewall rules and virtual network rules
- Extended auditing policy
- Security alert policy (threat detection)
- Customer-managed key (CMK) for TDE
- Managed identity support

## Usage

### Basic Server with SQL Authentication

```hcl
module "sql_server" {
  source = "./Database/SQLServer"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "myapp"
  environment = "dev"

  administrator_login          = "sqladmin"
  administrator_login_password = var.sql_admin_password

  # Security: Disable public access by default
  public_network_access_enabled = false
}
```

### Azure AD-Only Authentication (Recommended)

```hcl
module "sql_server" {
  source = "./Database/SQLServer"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "enterprise"
  environment = "prod"

  # Azure AD-only authentication (most secure)
  azuread_administrator = {
    login_username              = "SQL-Admins"
    object_id                   = data.azuread_group.sql_admins.object_id
    azuread_authentication_only = true
  }

  public_network_access_enabled = false

  identity = {
    type = "SystemAssigned"
  }
}
```

### With VNet Integration

```hcl
module "sql_server" {
  source = "./Database/SQLServer"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "secure"
  environment = "prod"

  administrator_login          = "sqladmin"
  administrator_login_password = var.sql_admin_password

  azuread_administrator = {
    login_username = "SQL-Admins"
    object_id      = data.azuread_group.sql_admins.object_id
  }

  # Network security
  public_network_access_enabled = true  # Required for VNet rules

  virtual_network_rules = [
    {
      name      = "app-subnet"
      subnet_id = azurerm_subnet.app.id
    },
    {
      name      = "data-subnet"
      subnet_id = azurerm_subnet.data.id
    }
  ]

  # Allow specific IPs (e.g., corporate network)
  firewall_rules = [
    {
      name             = "corporate-office"
      start_ip_address = "203.0.113.0"
      end_ip_address   = "203.0.113.255"
    }
  ]
}
```

### With Auditing and Threat Detection

```hcl
module "sql_server" {
  source = "./Database/SQLServer"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "compliant"
  environment = "prod"

  administrator_login          = "sqladmin"
  administrator_login_password = var.sql_admin_password

  azuread_administrator = {
    login_username = "SQL-Admins"
    object_id      = data.azuread_group.sql_admins.object_id
  }

  # Auditing (required for compliance)
  extended_auditing_policy = {
    enabled              = true
    retention_in_days    = 90
    log_monitoring_enabled = true
    storage_endpoint     = azurerm_storage_account.audit.primary_blob_endpoint
    storage_account_access_key = azurerm_storage_account.audit.primary_access_key
  }

  # Threat detection
  security_alert_policy = {
    state                = "Enabled"
    email_account_admins = true
    email_addresses      = ["security@example.com"]
    retention_days       = 30
  }

  identity = {
    type = "SystemAssigned"
  }
}
```

### With Customer-Managed Key (CMK)

```hcl
module "sql_server" {
  source = "./Database/SQLServer"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "encrypted"
  environment = "prod"

  azuread_administrator = {
    login_username              = "SQL-Admins"
    object_id                   = data.azuread_group.sql_admins.object_id
    azuread_authentication_only = true
  }

  # CMK for TDE
  identity = {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.sql.id]
  }
  primary_user_assigned_identity_id            = azurerm_user_assigned_identity.sql.id
  transparent_data_encryption_key_vault_key_id = azurerm_key_vault_key.sql_tde.id

  public_network_access_enabled = false
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
| name | Server name (globally unique) | `string` | `null` | no |
| workload | Workload name | `string` | `""` | no |
| environment | Environment name | `string` | `""` | no |
| version | SQL Server version | `string` | `"12.0"` | no |
| administrator_login | SQL admin username | `string` | `null` | no* |
| administrator_login_password | SQL admin password | `string` | `null` | no* |
| azuread_administrator | Azure AD admin config | `object` | `null` | no |
| minimum_tls_version | Minimum TLS version | `string` | `"1.2"` | no |
| public_network_access_enabled | Allow public access | `bool` | `false` | no |
| connection_policy | Connection policy | `string` | `"Default"` | no |
| firewall_rules | Firewall rules | `list(object)` | `[]` | no |
| virtual_network_rules | VNet rules | `list(object)` | `[]` | no |
| extended_auditing_policy | Auditing config | `object` | `null` | no |
| security_alert_policy | Threat detection | `object` | `null` | no |
| identity | Managed identity | `object` | `null` | no |

*Required if not using Azure AD-only authentication

## Outputs

| Name | Description |
|------|-------------|
| id | SQL Server ID |
| name | SQL Server name |
| fully_qualified_domain_name | Server FQDN |
| identity | Identity configuration |
| principal_id | System assigned identity principal ID |
| firewall_rule_ids | Map of firewall rule IDs |
| virtual_network_rule_ids | Map of VNet rule IDs |

## Security Best Practices

1. **Use Azure AD authentication** - Prefer Azure AD-only auth when possible
2. **Disable public network access** - Use Private Endpoints instead
3. **Enable TLS 1.2** - Already default in this module
4. **Enable auditing** - Required for compliance
5. **Enable threat detection** - Detects anomalous activities
6. **Use CMK for TDE** - For sensitive data requiring BYOK
7. **Use VNet rules** - Restrict access to specific subnets

## Notes

- Server names must be globally unique
- TLS 1.2 is enforced by default for security
- Consider using Private Endpoints for production
- Azure AD-only auth is the most secure option
