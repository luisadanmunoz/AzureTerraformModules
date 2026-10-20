# Azure Automation Variable Module

Terraform module to create and manage **Azure Automation Variables** with support for all variable types: String, Integer, Boolean, DateTime, and Object (JSON).

## Features

- Support for all variable types (String, Int, Bool, DateTime, Object)
- Multiple variables of each type in a single module call
- Encrypted variables for sensitive data
- Object/JSON variables with automatic JSON encoding
- Conditional creation with `create = true/false`

## Usage - String Variables

```hcl
module "automation_variables" {
  source = "path/to/Automation/AutomationVariable"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"

  string_variables = {
    "SubscriptionId" = {
      value       = "00000000-0000-0000-0000-000000000000"
      description = "Target subscription ID"
    }
    "Environment" = {
      value       = "Production"
      description = "Environment name"
    }
    "ApiKey" = {
      value       = "secret-api-key-value"
      description = "API Key for external service"
      encrypted   = true
    }
  }
}
```

## Usage - Integer Variables

```hcl
module "automation_variables" {
  source = "path/to/Automation/AutomationVariable"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"

  int_variables = {
    "MaxRetries" = {
      value       = 3
      description = "Maximum number of retries"
    }
    "TimeoutSeconds" = {
      value       = 300
      description = "Operation timeout in seconds"
    }
    "BatchSize" = {
      value       = 100
      description = "Number of items to process per batch"
    }
  }
}
```

## Usage - Boolean Variables

```hcl
module "automation_variables" {
  source = "path/to/Automation/AutomationVariable"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"

  bool_variables = {
    "EnableNotifications" = {
      value       = true
      description = "Send email notifications on completion"
    }
    "DryRun" = {
      value       = false
      description = "Run in dry-run mode without making changes"
    }
    "MaintenanceMode" = {
      value       = false
      description = "Enable maintenance mode"
    }
  }
}
```

## Usage - DateTime Variables

```hcl
module "automation_variables" {
  source = "path/to/Automation/AutomationVariable"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"

  datetime_variables = {
    "MaintenanceWindowStart" = {
      value       = "2024-01-15T02:00:00Z"
      description = "Start of maintenance window"
    }
    "LastRunTime" = {
      value       = "2024-01-01T00:00:00Z"
      description = "Last successful run timestamp"
    }
  }
}
```

## Usage - Object/JSON Variables

```hcl
module "automation_variables" {
  source = "path/to/Automation/AutomationVariable"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"

  object_variables = {
    "VMConfiguration" = {
      value = {
        sizes       = ["Standard_D2s_v3", "Standard_D4s_v3"]
        regions     = ["westeurope", "northeurope"]
        max_count   = 10
        auto_delete = true
      }
      description = "VM deployment configuration"
    }
    "NotificationSettings" = {
      value = {
        email_recipients = ["admin@example.com", "ops@example.com"]
        send_on_failure  = true
        send_on_success  = false
      }
      description = "Notification configuration"
      encrypted   = true
    }
  }
}
```

## Usage - All Variable Types Combined

```hcl
module "automation_variables" {
  source = "path/to/Automation/AutomationVariable"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"

  string_variables = {
    "Environment" = {
      value       = "Production"
      description = "Environment name"
    }
  }

  int_variables = {
    "MaxRetries" = {
      value       = 3
      description = "Maximum retries"
    }
  }

  bool_variables = {
    "EnableLogging" = {
      value       = true
      description = "Enable verbose logging"
    }
  }

  datetime_variables = {
    "DeploymentDate" = {
      value       = "2024-01-01T00:00:00Z"
      description = "Initial deployment date"
    }
  }

  object_variables = {
    "Config" = {
      value = {
        setting1 = "value1"
        setting2 = 42
      }
      description = "Configuration object"
    }
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create` | Controls whether to create the variables | `bool` | `true` | no |
| `resource_group_name` | Name of the Resource Group | `string` | - | yes |
| `automation_account_name` | Name of the Automation Account | `string` | - | yes |
| `string_variables` | Map of string variables | `map(object)` | `{}` | no |
| `int_variables` | Map of integer variables | `map(object)` | `{}` | no |
| `bool_variables` | Map of boolean variables | `map(object)` | `{}` | no |
| `datetime_variables` | Map of datetime variables (RFC3339 format) | `map(object)` | `{}` | no |
| `object_variables` | Map of object variables (auto JSON-encoded) | `map(object)` | `{}` | no |

### Variable Object Attributes

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `value` | The value of the variable | `varies` | - | yes |
| `description` | Description of the variable | `string` | `null` | no |
| `encrypted` | Whether to encrypt the variable | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| `string_variable_ids` | Map of string variable names to their IDs |
| `int_variable_ids` | Map of integer variable names to their IDs |
| `bool_variable_ids` | Map of boolean variable names to their IDs |
| `datetime_variable_ids` | Map of datetime variable names to their IDs |
| `object_variable_ids` | Map of object variable names to their IDs |
| `all_variable_ids` | Map of all variable names to their IDs (merged) |

## Dependencies

- **Resource Group** must exist
- **Automation Account** must exist before creating variables

## Notes

- Encrypted variables cannot have their values read back after creation
- Object variables are stored as JSON-encoded strings
- DateTime values must be in RFC3339 format (e.g., "2024-01-01T00:00:00Z")

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
| [azurerm_automation_variable_bool.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_variable_bool) | resource |
| [azurerm_automation_variable_datetime.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_variable_datetime) | resource |
| [azurerm_automation_variable_int.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_variable_int) | resource |
| [azurerm_automation_variable_object.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_variable_object) | resource |
| [azurerm_automation_variable_string.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_variable_string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_automation_account_name"></a> [automation\_account\_name](#input\_automation\_account\_name) | (Required) The name of the Automation Account where the Variables will be created. DEPENDENCY: Automation Account must exist. | `string` | n/a | yes |
| <a name="input_bool_variables"></a> [bool\_variables](#input\_bool\_variables) | (Optional) Map of boolean variables to create.<br/>- value: (Required) The boolean value of the variable.<br/>- description: (Optional) Description of the variable.<br/>- encrypted: (Optional) Whether the variable is encrypted. Default: false. | <pre>map(object({<br/>    value       = bool<br/>    description = optional(string, null)<br/>    encrypted   = optional(bool, false)<br/>  }))</pre> | `{}` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Automation Variables. | `bool` | `true` | no |
| <a name="input_datetime_variables"></a> [datetime\_variables](#input\_datetime\_variables) | (Optional) Map of datetime variables to create.<br/>- value: (Required) The datetime value in RFC3339 format (e.g., "2024-01-01T00:00:00Z").<br/>- description: (Optional) Description of the variable.<br/>- encrypted: (Optional) Whether the variable is encrypted. Default: false. | <pre>map(object({<br/>    value       = string<br/>    description = optional(string, null)<br/>    encrypted   = optional(bool, false)<br/>  }))</pre> | `{}` | no |
| <a name="input_int_variables"></a> [int\_variables](#input\_int\_variables) | (Optional) Map of integer variables to create.<br/>- value: (Required) The integer value of the variable.<br/>- description: (Optional) Description of the variable.<br/>- encrypted: (Optional) Whether the variable is encrypted. Default: false. | <pre>map(object({<br/>    value       = number<br/>    description = optional(string, null)<br/>    encrypted   = optional(bool, false)<br/>  }))</pre> | `{}` | no |
| <a name="input_object_variables"></a> [object\_variables](#input\_object\_variables) | (Optional) Map of object/JSON variables to create. Values are JSON-encoded.<br/>- value: (Required) The object value (will be JSON encoded).<br/>- description: (Optional) Description of the variable.<br/>- encrypted: (Optional) Whether the variable is encrypted. Default: false. | <pre>map(object({<br/>    value       = any<br/>    description = optional(string, null)<br/>    encrypted   = optional(bool, false)<br/>  }))</pre> | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the Automation Account exists. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_string_variables"></a> [string\_variables](#input\_string\_variables) | (Optional) Map of string variables to create.<br/>- value: (Required) The value of the variable.<br/>- description: (Optional) Description of the variable.<br/>- encrypted: (Optional) Whether the variable is encrypted. Default: false. | <pre>map(object({<br/>    value       = string<br/>    description = optional(string, null)<br/>    encrypted   = optional(bool, false)<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_all_variable_ids"></a> [all\_variable\_ids](#output\_all\_variable\_ids) | Map of all variable names to their IDs (merged). |
| <a name="output_bool_variable_ids"></a> [bool\_variable\_ids](#output\_bool\_variable\_ids) | Map of boolean variable names to their IDs. |
| <a name="output_datetime_variable_ids"></a> [datetime\_variable\_ids](#output\_datetime\_variable\_ids) | Map of datetime variable names to their IDs. |
| <a name="output_int_variable_ids"></a> [int\_variable\_ids](#output\_int\_variable\_ids) | Map of integer variable names to their IDs. |
| <a name="output_object_variable_ids"></a> [object\_variable\_ids](#output\_object\_variable\_ids) | Map of object variable names to their IDs. |
| <a name="output_string_variable_ids"></a> [string\_variable\_ids](#output\_string\_variable\_ids) | Map of string variable names to their IDs. |
<!-- END_TF_DOCS -->