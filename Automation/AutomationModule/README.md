# Azure Automation Module (PowerShell)

Terraform module to import **PowerShell modules** into an Azure Automation Account.

## Features

- Import modules from PowerShell Gallery
- Import modules from custom URIs (Storage Account, GitHub, etc.)
- Hash validation for content integrity
- Multiple modules in a single call
- Convenience variable for PowerShell Gallery with auto-generated URIs
- Conditional creation with `create = true/false`

## Usage - PowerShell Gallery Modules (Recommended)

```hcl
module "automation_modules" {
  source = "path/to/Automation/AutomationModule"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"

  # Simple syntax for PowerShell Gallery
  powershell_gallery_modules = {
    "Az.Accounts"       = { version = "2.13.1" }
    "Az.Compute"        = { version = "6.3.0" }
    "Az.Storage"        = { version = "5.10.1" }
    "Az.Resources"      = { version = "6.11.2" }
    "Az.KeyVault"       = { version = "4.11.0" }
    "SqlServer"         = { version = "22.0.59" }
    "AzureAD"           = { version = "2.0.2.182" }
  }
}
```

## Usage - Custom URI Modules

```hcl
module "automation_modules" {
  source = "path/to/Automation/AutomationModule"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"

  modules = {
    "CustomModule" = {
      uri     = "https://mystorageaccount.blob.core.windows.net/modules/CustomModule.zip"
      version = "1.0.0"
      hash = {
        algorithm = "SHA256"
        value     = "abc123def456..."
      }
    }
    "InternalTools" = {
      uri     = "https://github.com/org/repo/releases/download/v1.0/InternalTools.zip"
      version = "1.0.0"
    }
  }
}
```

## Usage - Mixed Sources

```hcl
module "automation_modules" {
  source = "path/to/Automation/AutomationModule"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"

  # From PowerShell Gallery
  powershell_gallery_modules = {
    "Az.Accounts" = { version = "2.13.1" }
    "Az.Compute"  = { version = "6.3.0" }
  }

  # From custom locations
  modules = {
    "CompanyModule" = {
      uri     = "https://artifacts.company.com/modules/CompanyModule-2.0.0.zip"
      version = "2.0.0"
    }
  }
}
```

## Usage - Az Module Dependencies

When importing Az modules, you must import them in the correct order due to dependencies.
`Az.Accounts` must be imported first as it's a dependency for all other Az modules.

```hcl
# Step 1: Import Az.Accounts first
module "az_accounts" {
  source = "path/to/Automation/AutomationModule"

  resource_group_name     = "rg-automation-prod-001"
  automation_account_name = "aa-runbooks-prod-001"

  powershell_gallery_modules = {
    "Az.Accounts" = { version = "2.13.1" }
  }
}

# Step 2: Import other Az modules (depends on Az.Accounts)
module "az_modules" {
  source = "path/to/Automation/AutomationModule"

  resource_group_name     = "rg-automation-prod-001"
  automation_account_name = "aa-runbooks-prod-001"

  powershell_gallery_modules = {
    "Az.Compute"   = { version = "6.3.0" }
    "Az.Storage"   = { version = "5.10.1" }
    "Az.Network"   = { version = "6.2.0" }
    "Az.KeyVault"  = { version = "4.11.0" }
    "Az.Monitor"   = { version = "4.5.0" }
  }

  depends_on = [module.az_accounts]
}
```

## Common PowerShell Gallery Modules

| Module | Description | Example Version |
|--------|-------------|-----------------|
| `Az.Accounts` | Azure authentication (required for all Az modules) | 2.13.1 |
| `Az.Compute` | VM management | 6.3.0 |
| `Az.Storage` | Storage account operations | 5.10.1 |
| `Az.Network` | Networking resources | 6.2.0 |
| `Az.KeyVault` | Key Vault secrets/keys | 4.11.0 |
| `Az.Resources` | Resource management | 6.11.2 |
| `Az.Sql` | Azure SQL Database | 4.10.0 |
| `Az.Monitor` | Monitoring and alerts | 4.5.0 |
| `SqlServer` | SQL Server cmdlets | 22.0.59 |
| `AzureAD` | Azure AD management | 2.0.2.182 |
| `Microsoft.Graph` | Microsoft Graph API | 2.6.1 |
| `Pester` | Testing framework | 5.5.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create` | Controls whether to create the modules | `bool` | `true` | no |
| `resource_group_name` | Name of the Resource Group | `string` | - | yes |
| `automation_account_name` | Name of the Automation Account | `string` | - | yes |
| `modules` | Map of modules with custom URIs | `map(object)` | `{}` | no |
| `powershell_gallery_modules` | Map of modules from PowerShell Gallery | `map(object)` | `{}` | no |

### Module Object Attributes

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| `uri` | URI to module package (.zip or .nupkg) | `string` | yes |
| `version` | Version string (for tracking) | `string` | no |
| `hash` | Hash validation configuration | `object` | no |

### PowerShell Gallery Module Attributes

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| `version` | Module version from PowerShell Gallery | `string` | yes |

## Outputs

| Name | Description |
|------|-------------|
| `module_ids` | Map of module names to their IDs |
| `module_names` | List of imported module names |
| `modules` | Full map of module resources |

## Dependencies

- **Resource Group** must exist
- **Automation Account** must exist before importing modules
- **Az.Accounts** must be imported before other Az.* modules

## Notes

- Module import is asynchronous; it may take a few minutes for large modules
- PowerShell Gallery URI format: `https://www.powershellgallery.com/api/v2/package/{Name}/{Version}`
- Always check module compatibility with Azure Automation PowerShell version
- Some modules require specific dependencies to be installed first

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
| [azurerm_automation_module.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_module) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_automation_account_name"></a> [automation\_account\_name](#input\_automation\_account\_name) | (Required) The name of the Automation Account where the Modules will be imported. DEPENDENCY: Automation Account must exist. | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Automation Modules. | `bool` | `true` | no |
| <a name="input_modules"></a> [modules](#input\_modules) | (Optional) Map of PowerShell modules to import. The key is the module name.<br/>- uri: (Required) The URI to the module package (.zip or .nupkg).<br/>       For PowerShell Gallery: https://www.powershellgallery.com/api/v2/package/{ModuleName}/{Version}<br/>- version: (Optional) Version string for documentation/tracking purposes.<br/>- hash: (Optional) Hash configuration for content validation.<br/>  - algorithm: Hash algorithm (e.g., SHA256).<br/>  - value: The hash value. | <pre>map(object({<br/>    uri     = string<br/>    version = optional(string, null)<br/>    hash = optional(object({<br/>      algorithm = string<br/>      value     = string<br/>    }), null)<br/>  }))</pre> | `{}` | no |
| <a name="input_powershell_gallery_modules"></a> [powershell\_gallery\_modules](#input\_powershell\_gallery\_modules) | (Optional) Map of modules to import from PowerShell Gallery. The key is the module name.<br/>- version: (Required) The version of the module to import.<br/>Note: This is a convenience variable that auto-generates the PowerShell Gallery URI. | <pre>map(object({<br/>    version = string<br/>  }))</pre> | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the Automation Account exists. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_module_ids"></a> [module\_ids](#output\_module\_ids) | Map of module names to their IDs. |
| <a name="output_module_names"></a> [module\_names](#output\_module\_names) | List of imported module names. |
| <a name="output_modules"></a> [modules](#output\_modules) | Full map of module resources with all attributes. |
<!-- END_TF_DOCS -->