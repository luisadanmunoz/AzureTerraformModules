# Azure Machine Learning Workspace

Terraform module for creating Azure Machine Learning Workspaces.

## Features

- ML Workspace with required dependencies
- System and User Assigned Managed Identity
- Container Registry integration
- High business impact support
- Network isolation options

## Usage

```hcl
module "ml_workspace" {
  source = "path/to/IA/MLWorkspace"

  name                    = "mlw-prod-001"
  resource_group_name     = azurerm_resource_group.ml.name
  location                = "westeurope"
  application_insights_id = azurerm_application_insights.ml.id
  key_vault_id            = azurerm_key_vault.ml.id
  storage_account_id      = azurerm_storage_account.ml.id
  container_registry_id   = azurerm_container_registry.ml.id

  tags = {
    Environment = "Production"
  }
}
```

## Required Dependencies

- Storage Account (for datasets, models, outputs)
- Key Vault (for secrets and credentials)
- Application Insights (for monitoring)
- Container Registry (optional, for custom images)

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Workspace name | `string` | n/a | yes |
| resource_group_name | Resource group | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| application_insights_id | App Insights ID | `string` | n/a | yes |
| key_vault_id | Key Vault ID | `string` | n/a | yes |
| storage_account_id | Storage Account ID | `string` | n/a | yes |
| container_registry_id | ACR ID | `string` | `null` | no |
| sku_name | SKU (Basic/Enterprise) | `string` | `"Basic"` | no |
| public_network_access_enabled | Allow public access | `bool` | `true` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The workspace ID |
| name | The workspace name |
| discovery_url | The discovery URL |
| workspace_id | The workspace GUID |
| principal_id | System identity principal ID |

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
| [azurerm_machine_learning_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_workspace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_application_insights_id"></a> [application\_insights\_id](#input\_application\_insights\_id) | The ID of the Application Insights instance. | `string` | n/a | yes |
| <a name="input_container_registry_id"></a> [container\_registry\_id](#input\_container\_registry\_id) | The ID of the Container Registry. | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the workspace. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | A description of the workspace. | `string` | `null` | no |
| <a name="input_friendly_name"></a> [friendly\_name](#input\_friendly\_name) | A friendly name for the workspace. | `string` | `null` | no |
| <a name="input_high_business_impact"></a> [high\_business\_impact](#input\_high\_business\_impact) | Whether this is a high business impact workspace. | `bool` | `false` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | List of User Assigned Managed Identity IDs. | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The type of managed identity. | `string` | `"SystemAssigned"` | no |
| <a name="input_image_build_compute_name"></a> [image\_build\_compute\_name](#input\_image\_build\_compute\_name) | The compute name for image build. | `string` | `null` | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | The ID of the Key Vault. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure region. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Machine Learning Workspace. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is enabled. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU of the workspace. Possible values: Basic, Enterprise. | `string` | `"Basic"` | no |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | The ID of the Storage Account. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resource. | `map(string)` | `{}` | no |
| <a name="input_v1_legacy_mode_enabled"></a> [v1\_legacy\_mode\_enabled](#input\_v1\_legacy\_mode\_enabled) | Whether v1 legacy mode is enabled. | `bool` | `false` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_discovery_url"></a> [discovery\_url](#output\_discovery\_url) | The discovery URL of the workspace. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the ML Workspace. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity block. |
| <a name="output_name"></a> [name](#output\_name) | The name of the ML Workspace. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The principal ID of the system-assigned identity. |
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | The workspace ID. |
<!-- END_TF_DOCS -->