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
| <a name="input_create"></a> [create](#input\_create) | Whether to create the OpenAI account. | `bool` | `true` | no |
| <a name="input_custom_subdomain_name"></a> [custom\_subdomain\_name](#input\_custom\_subdomain\_name) | The custom subdomain name for the OpenAI account. | `string` | `null` | no |
| <a name="input_customer_managed_key"></a> [customer\_managed\_key](#input\_customer\_managed\_key) | Customer managed key configuration. | <pre>object({<br/>    key_vault_key_id   = string<br/>    identity_client_id = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_dynamic_throttling_enabled"></a> [dynamic\_throttling\_enabled](#input\_dynamic\_throttling\_enabled) | Whether dynamic throttling is enabled. | `bool` | `false` | no |
| <a name="input_fqdns"></a> [fqdns](#input\_fqdns) | List of FQDNs allowed for the OpenAI account. | `list(string)` | `[]` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | List of User Assigned Managed Identity IDs. | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The type of managed identity. Possible values: SystemAssigned, UserAssigned, SystemAssigned, UserAssigned. | `string` | `"SystemAssigned"` | no |
| <a name="input_local_auth_enabled"></a> [local\_auth\_enabled](#input\_local\_auth\_enabled) | Whether local authentication is enabled. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region for the OpenAI account. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Azure OpenAI account. | `string` | n/a | yes |
| <a name="input_network_acls"></a> [network\_acls](#input\_network\_acls) | Network ACLs for the OpenAI account. | <pre>object({<br/>    default_action = string<br/>    ip_rules       = optional(list(string), [])<br/>    virtual_network_rules = optional(list(object({<br/>      subnet_id                            = string<br/>      ignore_missing_vnet_service_endpoint = optional(bool, false)<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_outbound_network_access_restricted"></a> [outbound\_network\_access\_restricted](#input\_outbound\_network\_access\_restricted) | Whether outbound network access is restricted. | `bool` | `false` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is enabled. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU of the OpenAI account. Typically S0. | `string` | `"S0"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The endpoint of the OpenAI account. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the OpenAI account. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity block. |
| <a name="output_name"></a> [name](#output\_name) | The name of the OpenAI account. |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The primary access key. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The principal ID of the system-assigned identity. |
| <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key) | The secondary access key. |
<!-- END_TF_DOCS -->