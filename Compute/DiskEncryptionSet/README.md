# DiskEncryptionSet

Terraform module for creating Azure Disk Encryption Sets (Customer Managed Keys).

## Features

- Customer Managed Key encryption for disks
- Automatic key rotation
- System or User Assigned Identity
- Automatic Key Vault access policy creation
- Confidential VM encryption support

## Usage

```hcl
module "disk_encryption_set" {
  source = "./Compute/DiskEncryptionSet"

  resource_group_name = "rg-compute-prod-001"
  location            = "westeurope"

  workload    = "vm"
  environment = "prod"

  key_vault_key_id          = azurerm_key_vault_key.disk.id
  key_vault_id              = azurerm_key_vault.main.id
  auto_key_rotation_enabled = true
}

# Use with VirtualMachine module
module "vm" {
  source = "./Compute/VirtualMachine"

  os_disk = {
    disk_encryption_set_id = module.disk_encryption_set.id
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls creation | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| name | DES name | `string` | `null` | no |
| key_vault_key_id | Key Vault Key ID | `string` | n/a | yes |
| encryption_type | Encryption type | `string` | `"EncryptionAtRestWithCustomerKey"` | no |
| auto_key_rotation_enabled | Auto key rotation | `bool` | `true` | no |
| identity_type | Identity type | `string` | `"SystemAssigned"` | no |
| key_vault_id | Key Vault ID for access policy | `string` | `null` | no |
| tags | Tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The DES ID |
| name | The DES name |
| principal_id | System Assigned Identity Principal ID |
| tenant_id | Identity Tenant ID |

## Notes

- Key Vault must have soft delete and purge protection enabled
- The DES identity needs Get, WrapKey, UnwrapKey permissions on the key

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
| [azurerm_disk_encryption_set.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set) | resource |
| [azurerm_key_vault_access_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_auto_key_rotation_enabled"></a> [auto\_key\_rotation\_enabled](#input\_auto\_key\_rotation\_enabled) | (Optional) Enable automatic key rotation. Default: true. | `bool` | `true` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Disk Encryption Set. | `bool` | `true` | no |
| <a name="input_create_key_vault_access_policy"></a> [create\_key\_vault\_access\_policy](#input\_create\_key\_vault\_access\_policy) | (Optional) Create Key Vault access policy for the DES identity. Default: true. | `bool` | `true` | no |
| <a name="input_encryption_type"></a> [encryption\_type](#input\_encryption\_type) | (Optional) Encryption type. Values: EncryptionAtRestWithCustomerKey, EncryptionAtRestWithPlatformAndCustomerKeys, ConfidentialVmEncryptedWithCustomerKey. Default: EncryptionAtRestWithCustomerKey. | `string` | `"EncryptionAtRestWithCustomerKey"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_federated_client_id"></a> [federated\_client\_id](#input\_federated\_client\_id) | (Optional) The federated client ID for multi-tenant encryption. | `string` | `null` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | (Optional) List of User Assigned Identity IDs. Required when identity\_type is UserAssigned. | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | (Optional) Identity type. Values: SystemAssigned, UserAssigned. Default: SystemAssigned. | `string` | `"SystemAssigned"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number for the naming convention. | `string` | `"001"` | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | (Optional) The ID of the Key Vault. Required if create\_key\_vault\_access\_policy is true. DEPENDENCY: Key Vault must exist. | `string` | `null` | no |
| <a name="input_key_vault_key_id"></a> [key\_vault\_key\_id](#input\_key\_vault\_key\_id) | (Required) The ID of the Key Vault Key for encryption. DEPENDENCY: Key Vault Key must exist. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the DES should exist. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the Disk Encryption Set. If not provided, a name will be generated. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for the generated name. Default: 'des'. | `string` | `"des"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for the naming convention. | `string` | `"disk"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Disk Encryption Set. |
| <a name="output_key_vault_access_policy_id"></a> [key\_vault\_access\_policy\_id](#output\_key\_vault\_access\_policy\_id) | The ID of the Key Vault Access Policy. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Disk Encryption Set. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The Principal ID of the System Assigned Managed Identity. |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | The Tenant ID of the Managed Identity. |
<!-- END_TF_DOCS -->