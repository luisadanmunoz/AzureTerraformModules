# Azure Automation Account Module

Terraform module to create and manage **Azure Automation Account** with support for managed identities, customer-managed keys, private endpoints, and diagnostic settings.

## Features

- Basic and Free SKU support
- System Assigned and User Assigned Managed Identities
- Customer Managed Key (CMK) encryption
- Private Endpoints for secure connectivity
- Diagnostic settings integration (Log Analytics, Storage, Event Hub)
- Local authentication control
- Public network access control
- Conditional creation with `create = true/false`

## Usage - Basic

```hcl
module "automation_account" {
  source = "path/to/Automation/AutomationAccount"

  resource_group_name = "rg-automation-dev-001"
  location            = "westeurope"

  tags = {
    Environment = "Development"
  }
}
```

## Usage - With System Assigned Identity

```hcl
module "automation_account" {
  source = "path/to/Automation/AutomationAccount"

  resource_group_name = "rg-automation-dev-001"
  location            = "westeurope"
  name                = "aa-runbooks-dev-001"

  identity = {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}
```

## Usage - With User Assigned Identity and CMK

```hcl
module "automation_account" {
  source = "path/to/Automation/AutomationAccount"

  resource_group_name = "rg-automation-prod-001"
  location            = "westeurope"
  name                = "aa-runbooks-prod-001"

  identity = {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.automation.id]
  }

  encryption = {
    key_vault_key_id          = azurerm_key_vault_key.automation.id
    user_assigned_identity_id = azurerm_user_assigned_identity.automation.id
  }

  public_network_access_enabled = false
  local_authentication_enabled  = false

  tags = {
    Environment = "Production"
  }
}
```

## Usage - With Private Endpoints

```hcl
module "automation_account" {
  source = "path/to/Automation/AutomationAccount"

  resource_group_name = "rg-automation-prod-001"
  location            = "westeurope"
  name                = "aa-runbooks-prod-001"

  public_network_access_enabled = false

  identity = {
    type = "SystemAssigned"
  }

  private_endpoints = [
    {
      name              = "pe-aa-webhook"
      subnet_id         = azurerm_subnet.private_endpoints.id
      subresource_names = ["Webhook"]
      private_dns_zone_ids = [
        azurerm_private_dns_zone.automation_webhook.id
      ]
    },
    {
      name              = "pe-aa-dsc"
      subnet_id         = azurerm_subnet.private_endpoints.id
      subresource_names = ["DSCAndHybridWorker"]
      private_dns_zone_ids = [
        azurerm_private_dns_zone.automation_dsc.id
      ]
    }
  ]

  tags = {
    Environment = "Production"
  }
}
```

## Usage - With Diagnostic Settings

```hcl
module "automation_account" {
  source = "path/to/Automation/AutomationAccount"

  resource_group_name = "rg-automation-prod-001"
  location            = "westeurope"
  name                = "aa-runbooks-prod-001"

  identity = {
    type = "SystemAssigned"
  }

  diagnostic_settings = {
    name                       = "diag-aa-runbooks"
    log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id
    enabled_log_categories     = ["JobLogs", "JobStreams", "DscNodeStatus", "AuditEvent"]
    metric_categories          = ["AllMetrics"]
  }

  tags = {
    Environment = "Production"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create` | Controls whether to create the resource | `bool` | `true` | no |
| `resource_group_name` | Name of the Resource Group | `string` | - | yes |
| `location` | Azure Region | `string` | - | yes |
| `name` | Explicit name for the Automation Account | `string` | `null` | no |
| `name_prefix` | Prefix for generated name | `string` | `"aa"` | no |
| `workload` | Workload name for naming convention | `string` | `"automation"` | no |
| `environment` | Environment name | `string` | `"dev"` | no |
| `instance` | Instance number | `string` | `"001"` | no |
| `sku_name` | SKU: Free or Basic | `string` | `"Basic"` | no |
| `local_authentication_enabled` | Enable local authentication | `bool` | `true` | no |
| `public_network_access_enabled` | Enable public network access | `bool` | `true` | no |
| `identity` | Managed identity configuration | `object` | `null` | no |
| `encryption` | CMK encryption configuration | `object` | `null` | no |
| `private_endpoints` | List of private endpoints | `list(object)` | `[]` | no |
| `diagnostic_settings` | Diagnostic settings configuration | `object` | `null` | no |
| `tags` | Tags to assign | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The ID of the Automation Account |
| `name` | The name of the Automation Account |
| `dsc_server_endpoint` | The DSC Server Endpoint URL |
| `dsc_primary_access_key` | The Primary Access Key for DSC (sensitive) |
| `dsc_secondary_access_key` | The Secondary Access Key for DSC (sensitive) |
| `hybrid_service_url` | The URL of the Hybrid Worker Service |
| `identity` | The identity block |
| `principal_id` | The Principal ID of System Assigned Identity |
| `tenant_id` | The Tenant ID of System Assigned Identity |
| `private_endpoint_ids` | Map of Private Endpoint names to IDs |
| `private_endpoint_ips` | Map of Private Endpoint names to private IPs |

## Dependencies

- **Resource Group** must exist before creating the Automation Account
- **User Assigned Identity** must exist if using UserAssigned identity type
- **Key Vault Key** must exist if using CMK encryption
- **Subnet** must exist for Private Endpoints
- **Private DNS Zones** should exist for Private Endpoint DNS integration
- **Log Analytics Workspace** / **Storage Account** / **Event Hub** must exist for diagnostic settings

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
| [azurerm_automation_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_account) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Automation Account. | `bool` | `true` | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | (Optional) Diagnostic settings for the Automation Account.<br/>- name: (Required) Name of the diagnostic setting.<br/>- log\_analytics\_workspace\_id: (Optional) Log Analytics Workspace ID. DEPENDENCY: Log Analytics must exist.<br/>- storage\_account\_id: (Optional) Storage Account ID for archiving. DEPENDENCY: Storage Account must exist.<br/>- eventhub\_authorization\_rule\_id: (Optional) Event Hub authorization rule ID. DEPENDENCY: Event Hub must exist.<br/>- eventhub\_name: (Optional) Event Hub name.<br/>- enabled\_log\_categories: (Optional) List of log categories to enable.<br/>- metric\_categories: (Optional) List of metric categories to enable. | <pre>object({<br/>    name                           = string<br/>    log_analytics_workspace_id     = optional(string, null)<br/>    storage_account_id             = optional(string, null)<br/>    eventhub_authorization_rule_id = optional(string, null)<br/>    eventhub_name                  = optional(string, null)<br/>    enabled_log_categories         = optional(list(string), ["JobLogs", "JobStreams", "DscNodeStatus", "AuditEvent"])<br/>    metric_categories              = optional(list(string), ["AllMetrics"])<br/>  })</pre> | `null` | no |
| <a name="input_encryption"></a> [encryption](#input\_encryption) | (Optional) Encryption configuration using Customer Managed Keys.<br/>- key\_vault\_key\_id: (Required) The ID of the Key Vault Key. DEPENDENCY: Key Vault Key must exist.<br/>- user\_assigned\_identity\_id: (Optional) The User Assigned Identity ID for accessing the Key Vault. DEPENDENCY: User Assigned Identity must exist and have access to Key Vault. | <pre>object({<br/>    key_vault_key_id           = string<br/>    user_assigned_identity_id  = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name for the naming convention (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) Identity configuration for the Automation Account.<br/>- type: (Required) Type of identity. Possible values: SystemAssigned, UserAssigned, SystemAssigned, UserAssigned.<br/>- identity\_ids: (Optional) List of User Assigned Identity IDs. Required when type contains UserAssigned. DEPENDENCY: User Assigned Identities must exist. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number for the naming convention. | `string` | `"001"` | no |
| <a name="input_local_authentication_enabled"></a> [local\_authentication\_enabled](#input\_local\_authentication\_enabled) | (Optional) Whether local authentication methods are enabled. Default: true. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Automation Account should exist. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the Automation Account. If not provided, a name will be generated using the naming convention. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for the generated name. Default: 'aa'. | `string` | `"aa"` | no |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | (Optional) List of Private Endpoints to create for the Automation Account.<br/>- name: (Required) Name of the Private Endpoint.<br/>- subnet\_id: (Required) The ID of the Subnet where the Private Endpoint will be created. DEPENDENCY: Subnet must exist.<br/>- subresource\_names: (Required) List of subresources to connect. Values: Webhook, DSCAndHybridWorker.<br/>- private\_dns\_zone\_ids: (Optional) List of Private DNS Zone IDs. DEPENDENCY: Private DNS Zones must exist.<br/>- is\_manual\_connection: (Optional) Manual approval required. Default: false. | <pre>list(object({<br/>    name                 = string<br/>    subnet_id            = string<br/>    subresource_names    = list(string)<br/>    private_dns_zone_ids = optional(list(string), [])<br/>    is_manual_connection = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Whether public network access is allowed. Default: true. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the Automation Account should exist. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | (Optional) The SKU of the Automation Account. Possible values: Free, Basic. Default: Basic. | `string` | `"Basic"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for the naming convention. | `string` | `"automation"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_dsc_primary_access_key"></a> [dsc\_primary\_access\_key](#output\_dsc\_primary\_access\_key) | The Primary Access Key for the DSC Endpoint. |
| <a name="output_dsc_secondary_access_key"></a> [dsc\_secondary\_access\_key](#output\_dsc\_secondary\_access\_key) | The Secondary Access Key for the DSC Endpoint. |
| <a name="output_dsc_server_endpoint"></a> [dsc\_server\_endpoint](#output\_dsc\_server\_endpoint) | The DSC Server Endpoint associated with this Automation Account. |
| <a name="output_hybrid_service_url"></a> [hybrid\_service\_url](#output\_hybrid\_service\_url) | The URL of the Hybrid Worker Service. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Automation Account. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity block of the Automation Account. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Automation Account. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The Principal ID of the System Assigned Identity (if enabled). |
| <a name="output_private_endpoint_ids"></a> [private\_endpoint\_ids](#output\_private\_endpoint\_ids) | Map of Private Endpoint names to their IDs. |
| <a name="output_private_endpoint_ips"></a> [private\_endpoint\_ips](#output\_private\_endpoint\_ips) | Map of Private Endpoint names to their private IP addresses. |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | The Tenant ID of the System Assigned Identity (if enabled). |
<!-- END_TF_DOCS -->