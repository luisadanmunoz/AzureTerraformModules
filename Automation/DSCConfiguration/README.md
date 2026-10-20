# Azure Automation DSC Configuration Module

Terraform module to create and manage **Azure Automation DSC (Desired State Configuration)** configurations.

## Features

- Create DSC Configurations from inline content or external URI
- Multiple configurations in a single module call
- Verbose logging support
- State output for tracking compilation status
- Conditional creation with `create = true/false`

## Usage - Inline Configuration

```hcl
module "dsc_configuration" {
  source = "path/to/Automation/DSCConfiguration"

  resource_group_name     = "rg-automation-dev-001"
  location                = "westeurope"
  automation_account_name = "aa-dsc-dev-001"

  configurations = {
    "WebServerConfig" = {
      content_embedded = <<-EOT
        Configuration WebServerConfig {
            Node "localhost" {
                WindowsFeature IIS {
                    Ensure = "Present"
                    Name   = "Web-Server"
                }
                WindowsFeature IISTools {
                    Ensure    = "Present"
                    Name      = "Web-Mgmt-Tools"
                    DependsOn = "[WindowsFeature]IIS"
                }
            }
        }
      EOT
      description = "Install and configure IIS web server"
      log_verbose = true
    }
  }

  tags = {
    Environment = "Development"
  }
}
```

## Usage - Multiple Configurations

```hcl
module "dsc_configurations" {
  source = "path/to/Automation/DSCConfiguration"

  resource_group_name     = "rg-automation-prod-001"
  location                = "westeurope"
  automation_account_name = "aa-dsc-prod-001"

  configurations = {
    "BaselineConfig" = {
      content_embedded = <<-EOT
        Configuration BaselineConfig {
            Node "localhost" {
                # Ensure Windows Update service is running
                Service WindowsUpdate {
                    Name        = "wuauserv"
                    State       = "Running"
                    StartupType = "Automatic"
                }

                # Ensure Remote Desktop is disabled
                Registry DisableRDP {
                    Ensure    = "Present"
                    Key       = "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Terminal Server"
                    ValueName = "fDenyTSConnections"
                    ValueData = "1"
                    ValueType = "Dword"
                }
            }
        }
      EOT
      description = "Security baseline configuration"
    }

    "WebServerConfig" = {
      content_embedded = <<-EOT
        Configuration WebServerConfig {
            Import-DscResource -ModuleName PSDesiredStateConfiguration

            Node "WebServer" {
                WindowsFeature IIS {
                    Ensure = "Present"
                    Name   = "Web-Server"
                }

                WindowsFeature ASPNet45 {
                    Ensure = "Present"
                    Name   = "Web-Asp-Net45"
                }

                File WebContent {
                    Ensure          = "Present"
                    Type            = "Directory"
                    DestinationPath = "C:\\inetpub\\wwwroot\\myapp"
                }
            }
        }
      EOT
      description = "Web server with ASP.NET"
      log_verbose = true
    }

    "SQLServerConfig" = {
      content_embedded = <<-EOT
        Configuration SQLServerConfig {
            Node "SQLServer" {
                WindowsFeature NetFramework {
                    Ensure = "Present"
                    Name   = "NET-Framework-45-Core"
                }

                Service SQLServer {
                    Name        = "MSSQLSERVER"
                    State       = "Running"
                    StartupType = "Automatic"
                }
            }
        }
      EOT
      description = "SQL Server baseline"
    }
  }

  tags = {
    Environment = "Production"
    ManagedBy   = "DSC"
  }
}
```

## Usage - With DSC Resources

```hcl
module "dsc_config" {
  source = "path/to/Automation/DSCConfiguration"

  resource_group_name     = "rg-automation-prod-001"
  location                = "westeurope"
  automation_account_name = "aa-dsc-prod-001"

  configurations = {
    "DomainJoinConfig" = {
      content_embedded = <<-EOT
        Configuration DomainJoinConfig {
            param (
                [Parameter(Mandatory)]
                [PSCredential]$DomainCredential,

                [Parameter(Mandatory)]
                [string]$DomainName
            )

            Import-DscResource -ModuleName PSDesiredStateConfiguration
            Import-DscResource -ModuleName ComputerManagementDsc

            Node "localhost" {
                Computer JoinDomain {
                    Name       = $env:COMPUTERNAME
                    DomainName = $DomainName
                    Credential = $DomainCredential
                }
            }
        }
      EOT
      description = "Join computer to Active Directory domain"
      log_verbose = true
    }
  }
}
```

## Compiling Configurations

After creating a DSC Configuration, you need to compile it to create Node Configurations (MOF files):

### Azure Portal
1. Go to Automation Account → State configuration (DSC) → Configurations
2. Select the configuration and click "Compile"

### PowerShell
```powershell
Start-AzAutomationDscCompilationJob `
    -ResourceGroupName "rg-automation-prod-001" `
    -AutomationAccountName "aa-dsc-prod-001" `
    -ConfigurationName "WebServerConfig" `
    -Parameters @{
        # Configuration parameters if needed
    }
```

### With Configuration Data
```powershell
$ConfigData = @{
    AllNodes = @(
        @{
            NodeName = "WebServer01"
            Role     = "WebServer"
        },
        @{
            NodeName = "WebServer02"
            Role     = "WebServer"
        }
    )
}

Start-AzAutomationDscCompilationJob `
    -ResourceGroupName "rg-automation-prod-001" `
    -AutomationAccountName "aa-dsc-prod-001" `
    -ConfigurationName "WebServerConfig" `
    -ConfigurationData $ConfigData
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create` | Controls whether to create the configurations | `bool` | `true` | no |
| `resource_group_name` | Name of the Resource Group | `string` | - | yes |
| `location` | Azure Region | `string` | - | yes |
| `automation_account_name` | Name of the Automation Account | `string` | - | yes |
| `configurations` | Map of DSC Configurations | `map(object)` | `{}` | no |
| `tags` | Tags to assign | `map(string)` | `{}` | no |

### Configuration Object Attributes

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| `content_embedded` | Inline DSC Configuration script | `string` | no* |
| `content_uri` | URI to DSC Configuration script | `string` | no* |
| `description` | Description of the configuration | `string` | no |
| `log_verbose` | Enable verbose logging | `bool` | no (default: false) |

> \* Either `content_embedded` or `content_uri` must be specified.

## Outputs

| Name | Description |
|------|-------------|
| `configuration_ids` | Map of configuration names to their IDs |
| `configuration_names` | List of created configuration names |
| `configuration_states` | Map of configuration names to their states |

## Dependencies

- **Resource Group** must exist
- **Automation Account** must exist
- **DSC Resources/Modules** must be imported into Automation Account if used in configuration

## Notes

- Configuration names must match the `Configuration` block name in the script
- After creating, configurations must be compiled to generate Node Configurations
- Node Configurations are named: `ConfigurationName.NodeName`
- Compilation can be triggered via Portal, PowerShell, or REST API
- DSC resources used in configurations must be imported as Automation Modules first

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
| [azurerm_automation_dsc_configuration.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_dsc_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_automation_account_name"></a> [automation\_account\_name](#input\_automation\_account\_name) | (Required) The name of the Automation Account. DEPENDENCY: Automation Account must exist. | `string` | n/a | yes |
| <a name="input_configurations"></a> [configurations](#input\_configurations) | (Optional) Map of DSC Configurations to create. The key is the configuration name.<br/>- content\_embedded: (Optional) The PowerShell DSC Configuration script content (inline).<br/>- content\_uri: (Optional) URI to the DSC Configuration script. Conflicts with content\_embedded.<br/>- description: (Optional) Description of the configuration.<br/>- log\_verbose: (Optional) Enable verbose logging. Default: false.<br/>Note: Either content\_embedded or content\_uri must be specified. | <pre>map(object({<br/>    content_embedded = optional(string, null)<br/>    content_uri      = optional(string, null)<br/>    description      = optional(string, null)<br/>    log_verbose      = optional(bool, false)<br/>  }))</pre> | `{}` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the DSC Configurations. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the DSC Configuration should exist. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the Automation Account exists. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_configuration_ids"></a> [configuration\_ids](#output\_configuration\_ids) | Map of DSC Configuration names to their IDs. |
| <a name="output_configuration_names"></a> [configuration\_names](#output\_configuration\_names) | List of created DSC Configuration names. |
| <a name="output_configuration_states"></a> [configuration\_states](#output\_configuration\_states) | Map of DSC Configuration names to their states. |
<!-- END_TF_DOCS -->