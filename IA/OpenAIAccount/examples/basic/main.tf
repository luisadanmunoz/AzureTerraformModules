################################################################################
# Example: Azure OpenAI Account
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

resource "azurerm_resource_group" "ai" {
  name     = "rg-openai"
  location = "eastus"
}

module "openai" {
  source = "../../"

  name                  = "openai-prod-001"
  resource_group_name   = azurerm_resource_group.ai.name
  location              = azurerm_resource_group.ai.location
  custom_subdomain_name = "mycompany-openai-prod"

  tags = {
    Environment = "Production"
    Purpose     = "AI-Services"
  }
}

output "openai_endpoint" {
  value = module.openai.endpoint
}

output "openai_id" {
  value = module.openai.id
}
