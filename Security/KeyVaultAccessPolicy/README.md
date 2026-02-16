# Key Vault Access Policy

Terraform module for Azure Key Vault Access Policy.

## Features

- Fine-grained permissions for keys, secrets, certificates, and storage
- Per-identity access policies for users, groups, and service principals
- Application-specific policies using application ID
- Conditional creation with `create` flag

## Usage

### Full Access Policy

```hcl
module "admin_policy" {
  source = "./Security/KeyVaultAccessPolicy"

  key_vault_id = module.keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  certificate_permissions = ["Get", "List", "Create", "Delete", "Import", "Update", "ManageContacts", "ManageIssuers", "GetIssuers", "ListIssuers", "SetIssuers", "DeleteIssuers", "Purge", "Recover"]
  key_permissions         = ["Get", "List", "Create", "Delete", "Import", "Update", "Recover", "Purge", "Encrypt", "Decrypt", "Sign", "Verify", "WrapKey", "UnwrapKey"]
  secret_permissions      = ["Get", "List", "Set", "Delete", "Recover", "Purge", "Backup", "Restore"]
  storage_permissions     = ["Get", "List", "Set", "Delete", "Update", "RegenerateKey", "Recover", "Purge"]
}
```

### Read-Only Policy

```hcl
module "readonly_policy" {
  source = "./Security/KeyVaultAccessPolicy"

  key_vault_id = module.keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.reader_object_id

  secret_permissions      = ["Get", "List"]
  key_permissions         = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
}
```

### Application-Specific Policy

```hcl
module "app_policy" {
  source = "./Security/KeyVaultAccessPolicy"

  key_vault_id   = module.keyvault.id
  tenant_id      = data.azurerm_client_config.current.tenant_id
  object_id      = azuread_service_principal.app.object_id
  application_id = azuread_application.app.application_id

  secret_permissions = ["Get", "List"]
  key_permissions    = ["Get", "List", "Sign", "Verify"]
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
| key_vault_id | Key Vault ID | `string` | n/a | yes |
| tenant_id | Azure AD tenant ID | `string` | n/a | yes |
| object_id | Principal object ID | `string` | n/a | yes |
| create | Create resources | `bool` | `true` | no |
| application_id | Application ID | `string` | `null` | no |
| certificate_permissions | Certificate permissions | `list(string)` | `[]` | no |
| key_permissions | Key permissions | `list(string)` | `[]` | no |
| secret_permissions | Secret permissions | `list(string)` | `[]` | no |
| storage_permissions | Storage permissions | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Access Policy ID |
| object_id | Principal object ID |
| tenant_id | Tenant ID |

## Best Practices

1. **Prefer RBAC over access policies** - Azure RBAC provides better governance, centralized management, and fine-grained scope control
2. **Follow least privilege** - Grant only the minimum permissions required for each principal
3. **Use separate policies per identity** - Create individual access policies rather than sharing credentials
4. **Audit permissions regularly** - Review access policies to remove stale or excessive permissions
5. **Use application ID for service principals** - Scope policies to specific applications when possible
