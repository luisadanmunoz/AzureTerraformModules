# Resource Lock

Terraform module for Azure Management Lock.

## Features

- Protect resources from accidental deletion or modification
- Lock levels: CanNotDelete and ReadOnly
- Support for resource group, resource, and subscription scopes

## Usage

### Lock Resource Group

```hcl
module "lock_rg" {
  source = "./Gobernanza/ResourceLock"

  name                = "do-not-delete"
  lock_level          = "CanNotDelete"
  scope_type          = "resource_group"
  resource_group_name = azurerm_resource_group.prod.name
  notes               = "Production resource group - do not delete"
}
```

### Lock Specific Resource

```hcl
module "lock_storage" {
  source = "./Gobernanza/ResourceLock"

  name       = "critical-data"
  lock_level = "CanNotDelete"
  scope_type = "resource"
  scope      = azurerm_storage_account.critical.id
  notes      = "Contains critical business data"
}
```

### ReadOnly Lock

```hcl
module "lock_readonly" {
  source = "./Gobernanza/ResourceLock"

  name                = "readonly-config"
  lock_level          = "ReadOnly"
  scope_type          = "resource_group"
  resource_group_name = azurerm_resource_group.config.name
  notes               = "Configuration - read only"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Lock name | `string` | n/a | yes |
| lock_level | Lock level | `string` | n/a | yes |
| scope_type | Scope type | `string` | `"resource_group"` | no |
| resource_group_name | Resource group name | `string` | `null` | no |
| scope | Resource scope | `string` | `null` | no |
| subscription_id | Subscription ID | `string` | `null` | no |
| notes | Lock notes | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Lock ID |
| name | Lock name |

## Lock Levels

| Level | Effect |
|-------|--------|
| CanNotDelete | Resources can be modified but not deleted |
| ReadOnly | Resources cannot be modified or deleted |

## Best Practices

1. **Lock production resources** - Protect critical infrastructure
2. **Use CanNotDelete** - Prefer this over ReadOnly for most cases
3. **Document locks** - Use notes to explain why lock exists
4. **Plan for maintenance** - Remember to remove/modify locks during planned changes
