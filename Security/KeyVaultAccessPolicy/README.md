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
| [azurerm_key_vault_access_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_application_id"></a> [application\_id](#input\_application\_id) | The application ID of the service principal for the access policy. | `string` | `null` | no |
| <a name="input_certificate_permissions"></a> [certificate\_permissions](#input\_certificate\_permissions) | List of certificate permissions granted to the principal. | `list(string)` | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_key_permissions"></a> [key\_permissions](#input\_key\_permissions) | List of key permissions granted to the principal. | `list(string)` | `[]` | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | The ID of the Key Vault where the access policy will be applied. | `string` | n/a | yes |
| <a name="input_object_id"></a> [object\_id](#input\_object\_id) | The object ID of the principal (user, group, or service principal) for the access policy. | `string` | n/a | yes |
| <a name="input_secret_permissions"></a> [secret\_permissions](#input\_secret\_permissions) | List of secret permissions granted to the principal. | `list(string)` | `[]` | no |
| <a name="input_storage_permissions"></a> [storage\_permissions](#input\_storage\_permissions) | List of storage permissions granted to the principal. | `list(string)` | `[]` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The Azure Active Directory tenant ID for the access policy. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Key Vault Access Policy. |
| <a name="output_object_id"></a> [object\_id](#output\_object\_id) | The object ID of the principal for the access policy. |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | The tenant ID of the access policy. |
<!-- END_TF_DOCS -->