# Azure Storage Queue Terraform Module

This module creates Azure Storage Queues within an existing Storage Account. It supports creating a single queue (using `count`) or multiple queues (using `for_each`).

## Features

- Create a single Storage Queue with explicit or generated naming
- Create multiple Storage Queues via a `queues` map using `for_each`
- Optional metadata assignment per queue
- Flexible naming convention with prefix/suffix support
- `create` flag to enable/disable resource creation

## Dependencies

Before using this module, ensure the following resources exist:

| Resource | Required | Description |
|----------|----------|-------------|
| Storage Account | **Yes** | The queue(s) must be created within an existing Storage Account |

## Usage

### Single Queue (Basic)

```hcl
module "storage_queue" {
  source = "../../Storage/StorageQueue"

  # DEPENDENCY: Storage Account must exist
  storage_account_name = "mystorageaccount001"

  # Explicit naming
  name = "orders-queue"

  metadata = {
    purpose = "order-processing"
  }

  tags = {
    Environment = "Development"
    Project     = "MyProject"
  }
}
```

### Single Queue with Naming Convention

```hcl
module "storage_queue" {
  source = "../../Storage/StorageQueue"

  # DEPENDENCY: Storage Account must exist
  storage_account_name = "mystorageaccount001"

  # Uses naming convention: queue-orders-prod-001
  name_prefix = "queue"
  workload    = "orders"
  environment = "prod"
  instance    = "001"

  metadata = {
    purpose = "order-processing"
  }
}
```

### Multiple Queues

```hcl
module "storage_queues" {
  source = "../../Storage/StorageQueue"

  # DEPENDENCY: Storage Account must exist
  storage_account_name = "mystorageaccount001"

  queues = {
    "orders-queue" = {
      metadata = {
        purpose = "order-processing"
        team    = "backend"
      }
    }
    "notifications-queue" = {
      metadata = {
        purpose = "email-notifications"
        team    = "communications"
      }
    }
    "audit-queue" = {
      metadata = {}
    }
  }

  tags = {
    Environment = "Production"
    Project     = "ECommerce"
  }
}
```

### Disabled Module (for conditional creation)

```hcl
module "storage_queue" {
  source = "../../Storage/StorageQueue"

  create = false  # Resources will not be created

  storage_account_name = "mystorageaccount001"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether to create the Storage Queue(s) | `bool` | `true` | no |
| storage_account_name | The name of the Storage Account (DEPENDENCY) | `string` | n/a | **yes** |
| name | Explicit name for a single queue | `string` | `null` | no |
| name_prefix | Prefix for generated name | `string` | `"queue"` | no |
| name_suffix | Suffix for generated name | `string` | `""` | no |
| workload | Workload name for naming convention | `string` | `"shared"` | no |
| environment | Environment name for naming convention | `string` | `"dev"` | no |
| instance | Instance identifier for naming convention | `string` | `"001"` | no |
| metadata | Metadata key-value pairs for a single queue | `map(string)` | `{}` | no |
| queues | Map of queues to create via for_each | `map(object({...}))` | `{}` | no |
| tags | Tags to assign to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the single Storage Queue |
| name | The name of the single Storage Queue |
| queue_ids | Map of queue names to their IDs (multiple queues) |
| queue_names | Map of queue keys to their names (multiple queues) |
| storage_account_name | The name of the Storage Account containing the queue(s) |

## Notes

- When the `queues` variable is provided (non-empty map), the module uses `for_each` to create multiple queues and the single queue (`name`/`name_prefix`) is not created.
- When `queues` is empty (default), the module creates a single queue using `count`, with the name determined by `name` or the generated naming convention.
- Queue names must be 3-63 characters, containing only lowercase letters, numbers, and hyphens. They must start and end with a letter or number.
- The `metadata` variable applies only to the single queue mode. For multiple queues, metadata is specified per queue within the `queues` map.
- The `tags` variable is tracked in module locals but note that `azurerm_storage_queue` does not support tags directly. Tags are available for organizational reference and future compatibility.

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
| [azurerm_storage_queue.multiple](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_queue.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Storage Queue. Set to false to disable resource creation without removing module code. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) The environment name (e.g., dev, staging, prod), used for naming convention. | `string` | `"dev"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number or identifier for naming convention. | `string` | `"001"` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | (Optional) A mapping of metadata key-value pairs to assign to the single Storage Queue. | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The explicit name for a single Storage Queue. If provided, overrides the generated name from name\_prefix. Mutually exclusive with 'queues' variable for naming a single queue. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix used for the generated queue name when 'name' is not provided. Default is 'queue'. | `string` | `"queue"` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | (Optional) Suffix to append to the generated queue name. Used when 'name' is not provided. | `string` | `""` | no |
| <a name="input_queues"></a> [queues](#input\_queues) | (Optional) A map of Storage Queues to create using for\_each. Each key is the queue name, and the value<br/>is an object with optional metadata. When this variable is provided, it takes precedence for creating<br/>multiple queues. The single queue (name/name\_prefix) is ignored when this is set.<br/><br/>Attributes:<br/>  - metadata: (Optional) A mapping of metadata key-value pairs for the queue.<br/><br/>Example:<br/>  queues = {<br/>    "orders-queue" = {<br/>      metadata = { purpose = "order-processing" }<br/>    }<br/>    "notifications-queue" = {<br/>      metadata = { purpose = "email-notifications" }<br/>    }<br/>  } | <pre>map(object({<br/>    metadata = optional(map(string), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | (Required) The name of the Storage Account where the queue(s) will be created.<br/>DEPENDENCY: Storage Account must exist before creating the queue. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to resources. These are merged with default module tags. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) The workload or application name, used for naming convention. | `string` | `"shared"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the single Storage Queue (when using count-based creation). |
| <a name="output_name"></a> [name](#output\_name) | The name of the single Storage Queue (when using count-based creation). |
| <a name="output_queue_ids"></a> [queue\_ids](#output\_queue\_ids) | Map of queue names to their IDs (when using for\_each-based creation with the queues variable). |
| <a name="output_queue_names"></a> [queue\_names](#output\_queue\_names) | Map of queue keys to their names (when using for\_each-based creation with the queues variable). |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | The name of the Storage Account containing the queue(s). |
<!-- END_TF_DOCS -->