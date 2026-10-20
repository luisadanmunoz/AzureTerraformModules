################################################################################
# Example: Azure OpenAI Deployment
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

resource "azurerm_cognitive_account" "openai" {
  name                  = "openai-prod-001"
  resource_group_name   = azurerm_resource_group.ai.name
  location              = azurerm_resource_group.ai.location
  kind                  = "OpenAI"
  sku_name              = "S0"
  custom_subdomain_name = "mycompany-openai"

  identity {
    type = "SystemAssigned"
  }
}

################################################################################
# GPT-4 Deployment
################################################################################

module "gpt4" {
  source = "../../"

  name                 = "gpt-4"
  cognitive_account_id = azurerm_cognitive_account.openai.id
  model_name           = "gpt-4"
  model_version        = "0613"
  scale_capacity       = 10
}

################################################################################
# GPT-3.5 Turbo Deployment
################################################################################

module "gpt35" {
  source = "../../"

  name                 = "gpt-35-turbo"
  cognitive_account_id = azurerm_cognitive_account.openai.id
  model_name           = "gpt-35-turbo"
  model_version        = "0613"
  scale_capacity       = 30
}

################################################################################
# Embeddings Deployment
################################################################################

module "embeddings" {
  source = "../../"

  name                 = "text-embedding-ada-002"
  cognitive_account_id = azurerm_cognitive_account.openai.id
  model_name           = "text-embedding-ada-002"
  model_version        = "2"
  scale_capacity       = 120
}

################################################################################
# Outputs
################################################################################

output "gpt4_deployment_id" {
  value = module.gpt4.id
}

output "gpt35_deployment_id" {
  value = module.gpt35.id
}

output "embeddings_deployment_id" {
  value = module.embeddings.id
}
