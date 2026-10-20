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
