# Azure OpenAI Deployment

Terraform module for deploying models in Azure OpenAI Service.

## Features

- Deploy GPT-4, GPT-3.5-Turbo, Embeddings, DALL-E, etc.
- Configure capacity (TPM)
- Responsible AI policy support
- Version upgrade options

## Usage

```hcl
module "gpt4_deployment" {
  source = "path/to/IA/OpenAIDeployment"

  name                 = "gpt-4"
  cognitive_account_id = module.openai.id
  model_name           = "gpt-4"
  model_version        = "0613"
  scale_capacity       = 10  # 10K TPM
}
```

### Multiple Deployments

```hcl
module "gpt35" {
  source = "path/to/IA/OpenAIDeployment"

  name                 = "gpt-35-turbo"
  cognitive_account_id = module.openai.id
  model_name           = "gpt-35-turbo"
  model_version        = "0613"
  scale_capacity       = 30
}

module "embeddings" {
  source = "path/to/IA/OpenAIDeployment"

  name                 = "text-embedding-ada-002"
  cognitive_account_id = module.openai.id
  model_name           = "text-embedding-ada-002"
  model_version        = "2"
  scale_capacity       = 120
}
```

## Available Models

| Model | Description |
|-------|-------------|
| gpt-4 | Most capable GPT-4 model |
| gpt-4-32k | GPT-4 with 32K context |
| gpt-35-turbo | Fast and cost-effective |
| text-embedding-ada-002 | Embeddings model |
| dall-e-3 | Image generation |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Deployment name | `string` | n/a | yes |
| cognitive_account_id | OpenAI account ID | `string` | n/a | yes |
| model_name | Model to deploy | `string` | n/a | yes |
| model_version | Model version | `string` | n/a | yes |
| scale_type | Scale type | `string` | `"Standard"` | no |
| scale_capacity | Capacity in K TPM | `number` | `1` | no |
| rai_policy_name | RAI policy name | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The deployment ID |
| name | The deployment name |
| model_name | The model name |
| model_version | The model version |

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
| [azurerm_cognitive_deployment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_deployment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cognitive_account_id"></a> [cognitive\_account\_id](#input\_cognitive\_account\_id) | The ID of the Cognitive Services (OpenAI) account. | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the deployment. | `bool` | `true` | no |
| <a name="input_model_format"></a> [model\_format](#input\_model\_format) | The format of the model. Default is OpenAI. | `string` | `"OpenAI"` | no |
| <a name="input_model_name"></a> [model\_name](#input\_model\_name) | The name of the model to deploy (e.g., gpt-4, gpt-35-turbo). | `string` | n/a | yes |
| <a name="input_model_version"></a> [model\_version](#input\_model\_version) | The version of the model to deploy. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the deployment. | `string` | n/a | yes |
| <a name="input_rai_policy_name"></a> [rai\_policy\_name](#input\_rai\_policy\_name) | The name of the RAI (Responsible AI) policy to apply. | `string` | `null` | no |
| <a name="input_scale_capacity"></a> [scale\_capacity](#input\_scale\_capacity) | The capacity (TPM in thousands) for the deployment. | `number` | `1` | no |
| <a name="input_scale_family"></a> [scale\_family](#input\_scale\_family) | The scale family for Standard deployments. | `string` | `null` | no |
| <a name="input_scale_size"></a> [scale\_size](#input\_scale\_size) | The scale size for Standard deployments. | `string` | `null` | no |
| <a name="input_scale_tier"></a> [scale\_tier](#input\_scale\_tier) | The scale tier for Standard deployments. | `string` | `null` | no |
| <a name="input_scale_type"></a> [scale\_type](#input\_scale\_type) | The scale type. Possible values: Standard, Manual. | `string` | `"Standard"` | no |
| <a name="input_version_upgrade_option"></a> [version\_upgrade\_option](#input\_version\_upgrade\_option) | Deployment version upgrade option. Possible values: OnceNewDefaultVersionAvailable, OnceCurrentVersionExpired, NoAutoUpgrade. | `string` | `"OnceNewDefaultVersionAvailable"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the deployment. |
| <a name="output_model_name"></a> [model\_name](#output\_model\_name) | The model name. |
| <a name="output_model_version"></a> [model\_version](#output\_model\_version) | The model version. |
| <a name="output_name"></a> [name](#output\_name) | The name of the deployment. |
<!-- END_TF_DOCS -->