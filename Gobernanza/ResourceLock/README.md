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
| [azurerm_management_lock.resource](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |
| [azurerm_management_lock.resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |
| [azurerm_management_lock.subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_lock_level"></a> [lock\_level](#input\_lock\_level) | The lock level. Possible values are CanNotDelete and ReadOnly. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the resource lock. | `string` | n/a | yes |
| <a name="input_notes"></a> [notes](#input\_notes) | Notes about the lock. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Resource Group for the lock (when scope\_type is resource\_group). | `string` | `null` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | The scope at which the lock should be created (for resource scope). | `string` | `null` | no |
| <a name="input_scope_type"></a> [scope\_type](#input\_scope\_type) | The type of scope for the lock: resource\_group, resource, or subscription. | `string` | `"resource_group"` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The ID of the Subscription for the lock (when scope\_type is subscription). | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Management Lock. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Management Lock. |
<!-- END_TF_DOCS -->