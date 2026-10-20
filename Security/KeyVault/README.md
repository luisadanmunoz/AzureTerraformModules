# Key Vault

Terraform module for Azure Key Vault.

## Features

- Standard and Premium SKUs
- RBAC or access policy authorization
- Network ACLs with VNet integration
- Purge protection and soft delete
- Certificate contacts
- Deployment and encryption integration

## Usage

### Basic Key Vault with RBAC

```hcl
module "keyvault" {
  source = "./Security/KeyVault"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tenant_id           = data.azurerm_client_config.current.tenant_id

  workload    = "myapp"
  environment = "prod"

  enable_rbac_authorization = true
  purge_protection_enabled  = true
}
```

### Production with Network Restrictions

```hcl
module "keyvault" {
  source = "./Security/KeyVault"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tenant_id           = data.azurerm_client_config.current.tenant_id

  workload    = "secure"
  environment = "prod"

  sku_name                      = "premium"
  enable_rbac_authorization     = true
  purge_protection_enabled      = true
  soft_delete_retention_days    = 90
  public_network_access_enabled = true

  network_acls = {
    bypass                     = "AzureServices"
    default_action             = "Deny"
    ip_rules                   = ["203.0.113.0/24"]
    virtual_network_subnet_ids = [azurerm_subnet.app.id]
  }

  enabled_for_disk_encryption = true
}
```

### With Access Policies

```hcl
module "keyvault" {
  source = "./Security/KeyVault"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tenant_id           = data.azurerm_client_config.current.tenant_id

  workload    = "legacy"
  environment = "prod"

  enable_rbac_authorization = false

  access_policies = [
    {
      object_id          = data.azurerm_client_config.current.object_id
      secret_permissions = ["Get", "List", "Set", "Delete"]
      key_permissions    = ["Get", "List", "Create", "Delete"]
    }
  ]
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
| resource_group_name | Resource group name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| tenant_id | Azure AD tenant ID | `string` | n/a | yes |
| name | Key Vault name | `string` | `null` | no |
| workload | Workload name | `string` | `""` | no |
| environment | Environment name | `string` | `""` | no |
| sku_name | SKU (standard/premium) | `string` | `"standard"` | no |
| enable_rbac_authorization | Use RBAC | `bool` | `true` | no |
| purge_protection_enabled | Enable purge protection | `bool` | `true` | no |
| soft_delete_retention_days | Retention days | `number` | `90` | no |
| network_acls | Network ACL config | `object` | `null` | no |
| access_policies | Access policies | `list(object)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Key Vault ID |
| name | Key Vault name |
| vault_uri | Key Vault URI |
| tenant_id | Tenant ID |

## Best Practices

1. **Use RBAC** - Prefer RBAC over access policies for better governance
2. **Enable purge protection** - Prevent permanent deletion of secrets
3. **Use Premium for HSM** - Required for HSM-backed keys
4. **Restrict network access** - Use private endpoints or VNet rules
5. **90 day retention** - Maximum retention for compliance

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
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_access_policies"></a> [access\_policies](#input\_access\_policies) | List of access policies for the Key Vault (ignored if RBAC is enabled). | <pre>list(object({<br/>    tenant_id               = optional(string)<br/>    object_id               = string<br/>    application_id          = optional(string)<br/>    certificate_permissions = optional(list(string), [])<br/>    key_permissions         = optional(list(string), [])<br/>    secret_permissions      = optional(list(string), [])<br/>    storage_permissions     = optional(list(string), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_contacts"></a> [contacts](#input\_contacts) | List of contacts for certificate notifications. | <pre>list(object({<br/>    email = string<br/>    name  = optional(string)<br/>    phone = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_enable_rbac_authorization"></a> [enable\_rbac\_authorization](#input\_enable\_rbac\_authorization) | Use RBAC instead of access policies. | `bool` | `true` | no |
| <a name="input_enabled_for_deployment"></a> [enabled\_for\_deployment](#input\_enabled\_for\_deployment) | Allow Azure VMs to retrieve certificates. | `bool` | `false` | no |
| <a name="input_enabled_for_disk_encryption"></a> [enabled\_for\_disk\_encryption](#input\_enabled\_for\_disk\_encryption) | Allow Azure Disk Encryption to retrieve secrets. | `bool` | `false` | no |
| <a name="input_enabled_for_template_deployment"></a> [enabled\_for\_template\_deployment](#input\_enabled\_for\_template\_deployment) | Allow ARM templates to retrieve secrets. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name (dev, staging, prod) for naming convention. | `string` | `""` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | The instance identifier for naming convention. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the Key Vault will be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Key Vault. Must be globally unique. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for the Key Vault name. | `string` | `"kv"` | no |
| <a name="input_network_acls"></a> [network\_acls](#input\_network\_acls) | Network ACL configuration for the Key Vault. | <pre>object({<br/>    bypass                     = optional(string, "AzureServices")<br/>    default_action             = optional(string, "Deny")<br/>    ip_rules                   = optional(list(string), [])<br/>    virtual_network_subnet_ids = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Allow public network access to the Key Vault. | `bool` | `true` | no |
| <a name="input_purge_protection_enabled"></a> [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | Enable purge protection (recommended for production). | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the Key Vault will be created. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name for the Key Vault. Possible values are standard and premium. | `string` | `"standard"` | no |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | Number of days to retain deleted vaults (7-90). | `number` | `90` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources. | `map(string)` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The Azure Active Directory tenant ID for the Key Vault. | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name for naming convention. | `string` | `""` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Key Vault. |
| <a name="output_location"></a> [location](#output\_location) | The location of the Key Vault. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Key Vault. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The resource group name of the Key Vault. |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | The tenant ID of the Key Vault. |
| <a name="output_vault_uri"></a> [vault\_uri](#output\_vault\_uri) | The URI of the Key Vault. |
<!-- END_TF_DOCS -->