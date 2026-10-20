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
| [azurerm_mssql_firewall_rule.allow_azure_services](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_firewall_rule) | resource |
| [azurerm_mssql_firewall_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_firewall_rule) | resource |
| [azurerm_mssql_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server) | resource |
| [azurerm_mssql_server_extended_auditing_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_extended_auditing_policy) | resource |
| [azurerm_mssql_server_security_alert_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_security_alert_policy) | resource |
| [azurerm_mssql_virtual_network_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_network_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_administrator_login"></a> [administrator\_login](#input\_administrator\_login) | The administrator login name for the SQL Server. Required if azuread\_authentication\_only is false. | `string` | `null` | no |
| <a name="input_administrator_login_password"></a> [administrator\_login\_password](#input\_administrator\_login\_password) | The administrator login password for the SQL Server. Required if azuread\_authentication\_only is false. | `string` | `null` | no |
| <a name="input_allow_azure_services"></a> [allow\_azure\_services](#input\_allow\_azure\_services) | Allow Azure services and resources to access this server. | `bool` | `false` | no |
| <a name="input_azuread_administrator"></a> [azuread\_administrator](#input\_azuread\_administrator) | Azure AD administrator configuration for the SQL Server. | <pre>object({<br/>    login_username              = string<br/>    object_id                   = string<br/>    tenant_id                   = optional(string)<br/>    azuread_authentication_only = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_connection_policy"></a> [connection\_policy](#input\_connection\_policy) | The connection policy for the SQL Server. Valid values are Default, Proxy, or Redirect. | `string` | `"Default"` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name (dev, staging, prod) for naming convention. | `string` | `""` | no |
| <a name="input_extended_auditing_policy"></a> [extended\_auditing\_policy](#input\_extended\_auditing\_policy) | Extended auditing policy configuration for the SQL Server. | <pre>object({<br/>    enabled                                 = optional(bool, true)<br/>    storage_endpoint                        = optional(string)<br/>    storage_account_access_key              = optional(string)<br/>    storage_account_access_key_is_secondary = optional(bool, false)<br/>    retention_in_days                       = optional(number, 90)<br/>    log_monitoring_enabled                  = optional(bool, true)<br/>  })</pre> | `null` | no |
| <a name="input_firewall_rules"></a> [firewall\_rules](#input\_firewall\_rules) | List of firewall rules to create for the SQL Server. | <pre>list(object({<br/>    name             = string<br/>    start_ip_address = string<br/>    end_ip_address   = string<br/>  }))</pre> | `[]` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | Managed identity configuration for the SQL Server. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | The instance identifier for naming convention. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the SQL Server will be created. | `string` | n/a | yes |
| <a name="input_minimum_tls_version"></a> [minimum\_tls\_version](#input\_minimum\_tls\_version) | The minimum TLS version for the SQL Server. Valid values are 1.0, 1.1, 1.2, and Disabled. | `string` | `"1.2"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the SQL Server. If not provided, will be generated from naming variables. Must be globally unique. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for the SQL Server name. | `string` | `"sql"` | no |
| <a name="input_outbound_network_restriction_enabled"></a> [outbound\_network\_restriction\_enabled](#input\_outbound\_network\_restriction\_enabled) | Whether outbound network traffic is restricted for the SQL Server. | `bool` | `false` | no |
| <a name="input_primary_user_assigned_identity_id"></a> [primary\_user\_assigned\_identity\_id](#input\_primary\_user\_assigned\_identity\_id) | The ID of the primary user assigned identity for the SQL Server. | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is allowed for the SQL Server. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the SQL Server will be created. | `string` | n/a | yes |
| <a name="input_security_alert_policy"></a> [security\_alert\_policy](#input\_security\_alert\_policy) | Security alert policy configuration for the SQL Server. | <pre>object({<br/>    state                      = optional(string, "Enabled")<br/>    disabled_alerts            = optional(list(string), [])<br/>    email_account_admins       = optional(bool, true)<br/>    email_addresses            = optional(list(string), [])<br/>    retention_days             = optional(number, 30)<br/>    storage_endpoint           = optional(string)<br/>    storage_account_access_key = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources. | `map(string)` | `{}` | no |
| <a name="input_transparent_data_encryption_key_vault_key_id"></a> [transparent\_data\_encryption\_key\_vault\_key\_id](#input\_transparent\_data\_encryption\_key\_vault\_key\_id) | The Key Vault Key ID for Transparent Data Encryption (TDE) with customer-managed key. | `string` | `null` | no |
| <a name="input_version"></a> [version](#input\_version) | The version of the SQL Server. Valid values are 2.0 (for v11 server) and 12.0 (for v12 server). | `string` | `"12.0"` | no |
| <a name="input_virtual_network_rules"></a> [virtual\_network\_rules](#input\_virtual\_network\_rules) | List of virtual network rules for the SQL Server. | <pre>list(object({<br/>    name                                 = string<br/>    subnet_id                            = string<br/>    ignore_missing_vnet_service_endpoint = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name for naming convention. | `string` | `""` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_firewall_rule_ids"></a> [firewall\_rule\_ids](#output\_firewall\_rule\_ids) | Map of firewall rule names to their IDs. |
| <a name="output_fully_qualified_domain_name"></a> [fully\_qualified\_domain\_name](#output\_fully\_qualified\_domain\_name) | The fully qualified domain name of the SQL Server. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the SQL Server. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity configuration of the SQL Server. |
| <a name="output_name"></a> [name](#output\_name) | The name of the SQL Server. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The principal ID of the system assigned identity (if enabled). |
| <a name="output_restorable_dropped_database_ids"></a> [restorable\_dropped\_database\_ids](#output\_restorable\_dropped\_database\_ids) | A list of dropped restorable database IDs on the server. |
| <a name="output_virtual_network_rule_ids"></a> [virtual\_network\_rule\_ids](#output\_virtual\_network\_rule\_ids) | Map of virtual network rule names to their IDs. |
<!-- END_TF_DOCS -->