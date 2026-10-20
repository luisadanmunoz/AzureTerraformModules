# Azure Automation Credential Module

Terraform module to create and manage **Azure Automation Credentials** for storing username/password pairs securely.

## Features

- Store username/password credentials securely
- Multiple credentials in a single module call
- Credentials are encrypted at rest
- Used by runbooks via `Get-AutomationPSCredential`
- Conditional creation with `create = true/false`

## Usage - Single Credential

```hcl
module "automation_credential" {
  source = "path/to/Automation/AutomationCredential"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"

  credentials = {
    "ServiceAccount" = {
      username    = "svc-automation@domain.com"
      password    = var.service_account_password
      description = "Service account for VM operations"
    }
  }
}
```

## Usage - Multiple Credentials

```hcl
module "automation_credentials" {
  source = "path/to/Automation/AutomationCredential"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"

  credentials = {
    "AzureAdmin" = {
      username    = "admin@contoso.onmicrosoft.com"
      password    = var.azure_admin_password
      description = "Azure AD admin account"
    }
    "SQLAdmin" = {
      username    = "sqladmin"
      password    = var.sql_admin_password
      description = "SQL Server admin credentials"
    }
    "VMLocalAdmin" = {
      username    = "localadmin"
      password    = var.vm_admin_password
      description = "Local admin for VMs"
    }
    "APIServiceAccount" = {
      username    = "api-service"
      password    = var.api_service_password
      description = "API service account"
    }
  }
}
```

## Usage - With Key Vault Integration

```hcl
data "azurerm_key_vault_secret" "sql_password" {
  name         = "sql-admin-password"
  key_vault_id = data.azurerm_key_vault.main.id
}

module "automation_credentials" {
  source = "path/to/Automation/AutomationCredential"

  resource_group_name     = "rg-automation-prod-001"
  automation_account_name = "aa-runbooks-prod-001"

  credentials = {
    "SQLAdmin" = {
      username    = "sqladmin"
      password    = data.azurerm_key_vault_secret.sql_password.value
      description = "SQL Server admin from Key Vault"
    }
  }
}
```

## Using Credentials in Runbooks

### PowerShell

```powershell
# Get credential object
$credential = Get-AutomationPSCredential -Name "SQLAdmin"

# Use with cmdlets that accept -Credential
Invoke-Command -ComputerName "server01" -Credential $credential -ScriptBlock {
    Get-Service
}

# Extract username and password if needed
$username = $credential.UserName
$password = $credential.GetNetworkCredential().Password
```

### Python

```python
import automationassets

# Get credential
credential = automationassets.get_automation_credential("SQLAdmin")
username = credential["username"]
password = credential["password"]
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create` | Controls whether to create the credentials | `bool` | `true` | no |
| `resource_group_name` | Name of the Resource Group | `string` | - | yes |
| `automation_account_name` | Name of the Automation Account | `string` | - | yes |
| `credentials` | Map of credentials to create | `map(object)` | `{}` | no |

### Credential Object Attributes

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| `username` | The username | `string` | yes |
| `password` | The password (sensitive) | `string` | yes |
| `description` | Description of the credential | `string` | no |

## Outputs

| Name | Description |
|------|-------------|
| `credential_ids` | Map of credential names to their IDs |
| `credential_names` | List of created credential names |

## Dependencies

- **Resource Group** must exist
- **Automation Account** must exist before creating credentials

## Security Notes

- Credentials are stored encrypted in Azure Automation
- Passwords cannot be retrieved after creation (write-only)
- Use Managed Identities when possible instead of credentials
- Consider using Key Vault references for password management
- The `credentials` variable is marked as sensitive in Terraform
