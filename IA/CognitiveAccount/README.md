# Azure Cognitive Services Account

Terraform module for creating Azure Cognitive Services accounts.

## Features

- Multiple service kinds (Vision, Speech, Language, etc.)
- Network ACLs and private endpoint support
- Managed identity
- Multi-service accounts

## Supported Kinds

| Kind | Description |
|------|-------------|
| CognitiveServices | Multi-service account |
| ComputerVision | Image analysis |
| Face | Face detection/recognition |
| FormRecognizer | Document AI |
| SpeechServices | Speech-to-text, text-to-speech |
| TextAnalytics | Language understanding |
| TextTranslation | Translation |
| LUIS | Language Understanding |

## Usage

```hcl
module "speech" {
  source = "path/to/IA/CognitiveAccount"

  name                = "cog-speech-prod"
  resource_group_name = azurerm_resource_group.ai.name
  location            = "westeurope"
  kind                = "SpeechServices"
  sku_name            = "S0"
}

module "vision" {
  source = "path/to/IA/CognitiveAccount"

  name                = "cog-vision-prod"
  resource_group_name = azurerm_resource_group.ai.name
  location            = "westeurope"
  kind                = "ComputerVision"
  sku_name            = "S1"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Account name | `string` | n/a | yes |
| resource_group_name | Resource group | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| kind | Service kind | `string` | n/a | yes |
| sku_name | SKU name | `string` | n/a | yes |
| public_network_access_enabled | Allow public access | `bool` | `true` | no |
| custom_subdomain_name | Custom subdomain | `string` | `null` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The account ID |
| endpoint | The endpoint |
| primary_access_key | Primary key (sensitive) |
| secondary_access_key | Secondary key (sensitive) |
