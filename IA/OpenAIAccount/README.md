# Azure OpenAI Account

Terraform module for creating Azure OpenAI Service accounts.

## Features

- Deploy Azure OpenAI service
- System and User Assigned Managed Identity
- Network ACLs and private endpoint support
- Customer managed keys (CMK)
- Dynamic throttling

## Usage

```hcl
module "openai" {
  source = "path/to/IA/OpenAIAccount"

  name                  = "openai-prod-001"
  resource_group_name   = azurerm_resource_group.ai.name
  location              = "eastus"
  custom_subdomain_name = "mycompany-openai"

  tags = {
    Environment = "Production"
  }
}
```

### With Network Restrictions

```hcl
module "openai_private" {
  source = "path/to/IA/OpenAIAccount"

  name                          = "openai-prod-001"
  resource_group_name           = azurerm_resource_group.ai.name
  location                      = "eastus"
  custom_subdomain_name         = "mycompany-openai"
  public_network_access_enabled = false

  network_acls = {
    default_action = "Deny"
    ip_rules       = ["203.0.113.0/24"]
    virtual_network_rules = [{
      subnet_id = azurerm_subnet.ai.id
    }]
  }
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
| name | Name of the OpenAI account | `string` | n/a | yes |
| resource_group_name | Resource group name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| sku_name | SKU name | `string` | `"S0"` | no |
| public_network_access_enabled | Allow public access | `bool` | `true` | no |
| custom_subdomain_name | Custom subdomain | `string` | `null` | no |
| network_acls | Network ACLs | `object` | `null` | no |
| identity_type | Identity type | `string` | `"SystemAssigned"` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The resource ID |
| name | The resource name |
| endpoint | The OpenAI endpoint |
| primary_access_key | Primary key (sensitive) |
| secondary_access_key | Secondary key (sensitive) |
| principal_id | System identity principal ID |
