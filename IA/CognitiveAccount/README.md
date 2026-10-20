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
| [azurerm_cognitive_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the account. | `bool` | `true` | no |
| <a name="input_custom_question_answering_search_service_id"></a> [custom\_question\_answering\_search\_service\_id](#input\_custom\_question\_answering\_search\_service\_id) | The Search Service ID for QnA Maker. | `string` | `null` | no |
| <a name="input_custom_subdomain_name"></a> [custom\_subdomain\_name](#input\_custom\_subdomain\_name) | The custom subdomain name. | `string` | `null` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | List of User Assigned Managed Identity IDs. | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The type of managed identity. | `string` | `null` | no |
| <a name="input_kind"></a> [kind](#input\_kind) | The kind of Cognitive Service. Possible values: AnomalyDetector, ComputerVision, ContentModerator, CustomVision.Prediction, CustomVision.Training, Face, FormRecognizer, ImmersiveReader, LUIS, Personalizer, SpeechServices, TextAnalytics, TextTranslation, CognitiveServices. | `string` | n/a | yes |
| <a name="input_local_auth_enabled"></a> [local\_auth\_enabled](#input\_local\_auth\_enabled) | Whether local authentication is enabled. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Cognitive Services account. | `string` | n/a | yes |
| <a name="input_network_acls"></a> [network\_acls](#input\_network\_acls) | Network ACLs for the account. | <pre>object({<br/>    default_action = string<br/>    ip_rules       = optional(list(string), [])<br/>    virtual_network_rules = optional(list(object({<br/>      subnet_id                            = string<br/>      ignore_missing_vnet_service_endpoint = optional(bool, false)<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_outbound_network_access_restricted"></a> [outbound\_network\_access\_restricted](#input\_outbound\_network\_access\_restricted) | Whether outbound network access is restricted. | `bool` | `false` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is enabled. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU of the Cognitive Services account. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The endpoint of the account. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Cognitive Services account. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity block. |
| <a name="output_name"></a> [name](#output\_name) | The name of the account. |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The primary access key. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The principal ID of the system-assigned identity. |
| <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key) | The secondary access key. |
<!-- END_TF_DOCS -->