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
