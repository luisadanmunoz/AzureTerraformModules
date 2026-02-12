################################################################################
# Basic Example - DSC Configuration Module
################################################################################

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.70.0, < 5.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "rg-automation-example-dev-001"
  location = "westeurope"
}

resource "azurerm_automation_account" "example" {
  name                = "aa-dsc-example-dev-001"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "Basic"
}

################################################################################
# DSC Configurations
################################################################################

module "dsc_configurations" {
  source = "../../"

  resource_group_name     = azurerm_resource_group.example.name
  location                = azurerm_resource_group.example.location
  automation_account_name = azurerm_automation_account.example.name

  configurations = {
    "BaselineConfig" = {
      content_embedded = <<-EOT
        Configuration BaselineConfig {
            Import-DscResource -ModuleName PSDesiredStateConfiguration

            Node "localhost" {
                # Ensure Windows Defender service is running
                Service WindowsDefender {
                    Name        = "WinDefend"
                    State       = "Running"
                    StartupType = "Automatic"
                }

                # Ensure TLS 1.2 is enabled
                Registry TLS12 {
                    Ensure    = "Present"
                    Key       = "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Protocols\\TLS 1.2\\Client"
                    ValueName = "Enabled"
                    ValueData = "1"
                    ValueType = "Dword"
                }
            }
        }
      EOT
      description = "Security baseline configuration"
      log_verbose = true
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

                WindowsFeature IISManagement {
                    Ensure    = "Present"
                    Name      = "Web-Mgmt-Console"
                    DependsOn = "[WindowsFeature]IIS"
                }

                File WebRoot {
                    Ensure          = "Present"
                    Type            = "Directory"
                    DestinationPath = "C:\\inetpub\\wwwroot\\app"
                    DependsOn       = "[WindowsFeature]IIS"
                }
            }
        }
      EOT
      description = "IIS Web Server configuration"
    }
  }

  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}

################################################################################
# Outputs
################################################################################

output "configuration_ids" {
  value = module.dsc_configurations.configuration_ids
}

output "configuration_names" {
  value = module.dsc_configurations.configuration_names
}

output "configuration_states" {
  value = module.dsc_configurations.configuration_states
}
