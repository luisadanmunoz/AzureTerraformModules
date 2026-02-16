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
