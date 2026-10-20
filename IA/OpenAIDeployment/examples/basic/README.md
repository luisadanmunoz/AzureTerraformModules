<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_embeddings"></a> [embeddings](#module\_embeddings) | ../../ | n/a |
| <a name="module_gpt35"></a> [gpt35](#module\_gpt35) | ../../ | n/a |
| <a name="module_gpt4"></a> [gpt4](#module\_gpt4) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_cognitive_account.openai](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account) | resource |
| [azurerm_resource_group.ai](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_embeddings_deployment_id"></a> [embeddings\_deployment\_id](#output\_embeddings\_deployment\_id) | n/a |
| <a name="output_gpt35_deployment_id"></a> [gpt35\_deployment\_id](#output\_gpt35\_deployment\_id) | n/a |
| <a name="output_gpt4_deployment_id"></a> [gpt4\_deployment\_id](#output\_gpt4\_deployment\_id) | n/a |
<!-- END_TF_DOCS -->