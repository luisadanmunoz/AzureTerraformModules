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
