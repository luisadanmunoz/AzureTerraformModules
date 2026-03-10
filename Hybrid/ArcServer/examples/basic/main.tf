################################################################################
# Example: Azure Arc-enabled Server
################################################################################

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.70.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "arc" {
  name     = "rg-arc-servers"
  location = "westeurope"
}

################################################################################
# Arc-enabled Server (VMware)
################################################################################

module "arc_vmware" {
  source = "../../"

  name                = "srv-vmware-prod-001"
  resource_group_name = azurerm_resource_group.arc.name
  location            = azurerm_resource_group.arc.location
  kind                = "VMware"

  tags = {
    Environment  = "Production"
    Datacenter   = "DC-Europe-1"
    Application  = "WebServer"
  }
}

################################################################################
# Arc-enabled Server (AWS)
################################################################################

module "arc_aws" {
  source = "../../"

  name                = "srv-aws-prod-001"
  resource_group_name = azurerm_resource_group.arc.name
  location            = azurerm_resource_group.arc.location
  kind                = "AWS"

  tags = {
    Environment  = "Production"
    CloudProvider = "AWS"
    Region        = "eu-west-1"
  }
}

################################################################################
# Outputs
################################################################################

output "vmware_server_id" {
  value = module.arc_vmware.id
}

output "aws_server_id" {
  value = module.arc_aws.id
}

output "vmware_principal_id" {
  value = module.arc_vmware.principal_id
}
