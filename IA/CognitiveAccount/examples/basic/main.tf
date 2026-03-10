################################################################################
# Example: Azure Cognitive Services Account
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
  name     = "rg-cognitive"
  location = "westeurope"
}

################################################################################
# Speech Services
################################################################################

module "speech" {
  source = "../../"

  name                = "cog-speech-prod"
  resource_group_name = azurerm_resource_group.ai.name
  location            = azurerm_resource_group.ai.location
  kind                = "SpeechServices"
  sku_name            = "S0"

  tags = {
    Service = "Speech"
  }
}

################################################################################
# Computer Vision
################################################################################

module "vision" {
  source = "../../"

  name                = "cog-vision-prod"
  resource_group_name = azurerm_resource_group.ai.name
  location            = azurerm_resource_group.ai.location
  kind                = "ComputerVision"
  sku_name            = "S1"

  tags = {
    Service = "Vision"
  }
}

################################################################################
# Text Analytics
################################################################################

module "language" {
  source = "../../"

  name                = "cog-language-prod"
  resource_group_name = azurerm_resource_group.ai.name
  location            = azurerm_resource_group.ai.location
  kind                = "TextAnalytics"
  sku_name            = "S"

  tags = {
    Service = "Language"
  }
}

################################################################################
# Outputs
################################################################################

output "speech_endpoint" {
  value = module.speech.endpoint
}

output "vision_endpoint" {
  value = module.vision.endpoint
}

output "language_endpoint" {
  value = module.language.endpoint
}
