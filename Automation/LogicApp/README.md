# Azure Logic App (Consumption) Module

Terraform module to create and manage **Azure Logic Apps (Consumption plan)** for workflow automation.

## Features

- Create Logic Apps with Consumption (pay-per-execution) billing
- System Assigned and User Assigned Managed Identities
- Access control for triggers, content, actions, and workflow management
- Integration Service Environment (ISE) support
- Integration Account linking
- Workflow parameters support
- Conditional creation with `create = true/false`

## Usage - Basic

```hcl
module "logic_app" {
  source = "path/to/Automation/LogicApp"

  resource_group_name = "rg-automation-dev-001"
  location            = "westeurope"
  name                = "logic-process-orders-dev-001"

  tags = {
    Environment = "Development"
  }
}
```

## Usage - With System Assigned Identity

```hcl
module "logic_app" {
  source = "path/to/Automation/LogicApp"

  resource_group_name = "rg-automation-dev-001"
  location            = "westeurope"
  name                = "logic-data-sync-dev-001"

  identity = {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}
```

## Usage - With Access Control

```hcl
module "logic_app" {
  source = "path/to/Automation/LogicApp"

  resource_group_name = "rg-automation-prod-001"
  location            = "westeurope"
  name                = "logic-api-handler-prod-001"

  identity = {
    type = "SystemAssigned"
  }

  access_control = {
    trigger = {
      allowed_caller_ip_address_range = ["10.0.0.0/8", "192.168.0.0/16"]
    }
    workflow_management = {
      allowed_caller_ip_address_range = ["10.0.0.0/8"]
    }
  }

  tags = {
    Environment = "Production"
  }
}
```

## Usage - With Integration Account

```hcl
module "logic_app" {
  source = "path/to/Automation/LogicApp"

  resource_group_name = "rg-automation-prod-001"
  location            = "westeurope"
  name                = "logic-b2b-process-prod-001"

  identity = {
    type = "SystemAssigned"
  }

  logic_app_integration_account_id = azurerm_logic_app_integration_account.main.id

  tags = {
    Environment = "Production"
    Purpose     = "B2B Integration"
  }
}
```

## Usage - With Workflow Parameters

```hcl
module "logic_app" {
  source = "path/to/Automation/LogicApp"

  resource_group_name = "rg-automation-dev-001"
  location            = "westeurope"
  name                = "logic-parameterized-dev-001"

  workflow_parameters = {
    "$connections" = jsonencode({
      defaultValue = {}
      type         = "Object"
    })
    "environment" = jsonencode({
      defaultValue = "development"
      type         = "String"
    })
  }

  parameters = {
    "environment" = "\"development\""
  }

  tags = {
    Environment = "Development"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create` | Controls whether to create the Logic App | `bool` | `true` | no |
| `resource_group_name` | Name of the Resource Group | `string` | - | yes |
| `location` | Azure Region | `string` | - | yes |
| `name` | Explicit name for the Logic App | `string` | `null` | no |
| `name_prefix` | Prefix for generated name | `string` | `"logic"` | no |
| `workload` | Workload name | `string` | `"app"` | no |
| `environment` | Environment name | `string` | `"dev"` | no |
| `instance` | Instance number | `string` | `"001"` | no |
| `enabled` | Whether the Logic App is enabled | `bool` | `true` | no |
| `workflow_schema` | Schema URI for workflow definition | `string` | (default schema) | no |
| `workflow_version` | Version of workflow schema | `string` | `"1.0.0.0"` | no |
| `workflow_parameters` | Map of workflow parameters (JSON) | `map(string)` | `{}` | no |
| `parameters` | Map of parameter values | `map(string)` | `{}` | no |
| `workflow_definition` | JSON-encoded workflow definition | `string` | `null` | no |
| `integration_service_environment_id` | ISE ID | `string` | `null` | no |
| `logic_app_integration_account_id` | Integration Account ID | `string` | `null` | no |
| `identity` | Managed identity configuration | `object` | `null` | no |
| `access_control` | Access control configuration | `object` | `null` | no |
| `tags` | Tags to assign | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The ID of the Logic App |
| `name` | The name of the Logic App |
| `access_endpoint` | The Access Endpoint URL |
| `connector_endpoint_ip_addresses` | Connector endpoint IP addresses |
| `connector_outbound_ip_addresses` | Connector outbound IP addresses |
| `workflow_endpoint_ip_addresses` | Workflow endpoint IP addresses |
| `workflow_outbound_ip_addresses` | Workflow outbound IP addresses |
| `identity` | The identity block |
| `principal_id` | Principal ID of System Assigned Identity |
| `tenant_id` | Tenant ID of System Assigned Identity |

## Dependencies

- **Resource Group** must exist
- **Integration Account** must exist if `logic_app_integration_account_id` is specified
- **ISE** must exist if `integration_service_environment_id` is specified
- **User Assigned Identities** must exist if using UserAssigned identity

## Notes

- Consumption Logic Apps are billed per execution
- Workflow definition is typically designed in Azure Portal or VS Code
- For complex B2B scenarios, use an Integration Account
- Consider Logic App Standard for VNet integration and predictable pricing

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
| [azurerm_logic_app_workflow.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_workflow) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_access_control"></a> [access\_control](#input\_access\_control) | (Optional) Access control configuration for triggers, contents, and actions.<br/>- trigger: (Optional) Access control for triggers with allowed\_caller\_ip\_address\_range list.<br/>- content: (Optional) Access control for contents with allowed\_caller\_ip\_address\_range list.<br/>- action: (Optional) Access control for actions with allowed\_caller\_ip\_address\_range list.<br/>- workflow\_management: (Optional) Access control for workflow management with allowed\_caller\_ip\_address\_range list. | <pre>object({<br/>    trigger = optional(object({<br/>      allowed_caller_ip_address_range = list(string)<br/>    }), null)<br/>    content = optional(object({<br/>      allowed_caller_ip_address_range = list(string)<br/>    }), null)<br/>    action = optional(object({<br/>      allowed_caller_ip_address_range = list(string)<br/>    }), null)<br/>    workflow_management = optional(object({<br/>      allowed_caller_ip_address_range = list(string)<br/>    }), null)<br/>  })</pre> | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Logic App. | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (Optional) Whether the Logic App is enabled. Default: true. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) Identity configuration for the Logic App.<br/>- type: (Required) Type of identity. Possible values: SystemAssigned, UserAssigned, SystemAssigned, UserAssigned.<br/>- identity\_ids: (Optional) List of User Assigned Identity IDs. DEPENDENCY: User Assigned Identities must exist. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number for the naming convention. | `string` | `"001"` | no |
| <a name="input_integration_service_environment_id"></a> [integration\_service\_environment\_id](#input\_integration\_service\_environment\_id) | (Optional) The ID of the Integration Service Environment. DEPENDENCY: ISE must exist. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Logic App should exist. | `string` | n/a | yes |
| <a name="input_logic_app_integration_account_id"></a> [logic\_app\_integration\_account\_id](#input\_logic\_app\_integration\_account\_id) | (Optional) The ID of the Logic App Integration Account. DEPENDENCY: Integration Account must exist. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the Logic App. If not provided, a name will be generated. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for the generated name. Default: 'logic'. | `string` | `"logic"` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | (Optional) Map of parameters for the workflow definition. | `map(string)` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_workflow_definition"></a> [workflow\_definition](#input\_workflow\_definition) | (Optional) The JSON-encoded workflow definition. If not provided, an empty workflow is created. | `string` | `null` | no |
| <a name="input_workflow_parameters"></a> [workflow\_parameters](#input\_workflow\_parameters) | (Optional) Map of workflow parameters in JSON format. | `map(string)` | `{}` | no |
| <a name="input_workflow_schema"></a> [workflow\_schema](#input\_workflow\_schema) | (Optional) The Schema URI for the workflow definition. | `string` | `"https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#"` | no |
| <a name="input_workflow_version"></a> [workflow\_version](#input\_workflow\_version) | (Optional) The version of the workflow schema. | `string` | `"1.0.0.0"` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for the naming convention. | `string` | `"app"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_access_endpoint"></a> [access\_endpoint](#output\_access\_endpoint) | The Access Endpoint for the Logic App Workflow. |
| <a name="output_connector_endpoint_ip_addresses"></a> [connector\_endpoint\_ip\_addresses](#output\_connector\_endpoint\_ip\_addresses) | The list of connector endpoint IP addresses. |
| <a name="output_connector_outbound_ip_addresses"></a> [connector\_outbound\_ip\_addresses](#output\_connector\_outbound\_ip\_addresses) | The list of outbound connector IP addresses. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Logic App Workflow. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity block of the Logic App. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Logic App Workflow. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The Principal ID of the System Assigned Identity. |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | The Tenant ID of the System Assigned Identity. |
| <a name="output_workflow_endpoint_ip_addresses"></a> [workflow\_endpoint\_ip\_addresses](#output\_workflow\_endpoint\_ip\_addresses) | The list of workflow endpoint IP addresses. |
| <a name="output_workflow_outbound_ip_addresses"></a> [workflow\_outbound\_ip\_addresses](#output\_workflow\_outbound\_ip\_addresses) | The list of workflow outbound IP addresses. |
<!-- END_TF_DOCS -->