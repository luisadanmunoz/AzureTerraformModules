# VMExtension-DomainJoin

Terraform module for joining Windows VMs to Active Directory domain.

## Features

- Join Windows VMs to AD domain
- Custom OU path placement
- Automatic restart after join

## Usage

```hcl
module "domain_join" {
  source = "./Compute/VMExtension-DomainJoin"

  virtual_machine_id = module.vm.id

  domain_name     = "corp.contoso.com"
  domain_username = "admin@corp.contoso.com"
  domain_password = var.domain_password
  ou_path         = "OU=Servers,DC=corp,DC=contoso,DC=com"
}
```

## Requirements

- Windows VM only
- Network connectivity to Domain Controller
- DNS configured to resolve domain

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| virtual_machine_id | VM ID | `string` | n/a | yes |
| domain_name | Domain FQDN | `string` | n/a | yes |
| domain_username | Domain admin user | `string` | n/a | yes |
| domain_password | Domain admin password | `string` | n/a | yes |
| ou_path | OU path for computer | `string` | `null` | no |
| join_options | Join options | `number` | `3` | no |

## Join Options

| Value | Description |
|-------|-------------|
| 1 | NETSETUP_JOIN_DOMAIN |
| 3 | JOIN + CREATE_ACCOUNT (default) |
| 35 | JOIN + CREATE + UNSECURE_JOIN |

## Outputs

| Name | Description |
|------|-------------|
| id | Extension ID |
| domain_name | Domain joined |

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
| [azurerm_virtual_machine_extension.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_auto_upgrade_minor_version"></a> [auto\_upgrade\_minor\_version](#input\_auto\_upgrade\_minor\_version) | (Optional) Auto upgrade minor version. Default: true. | `bool` | `true` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the extension. | `bool` | `true` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | (Required) The FQDN of the Active Directory domain to join. | `string` | n/a | yes |
| <a name="input_domain_password"></a> [domain\_password](#input\_domain\_password) | (Required) Password for the domain user. | `string` | n/a | yes |
| <a name="input_domain_username"></a> [domain\_username](#input\_domain\_username) | (Required) Username with permissions to join the domain (e.g., admin@domain.com). | `string` | n/a | yes |
| <a name="input_join_options"></a> [join\_options](#input\_join\_options) | (Optional) Domain join options. Default: 3 (NETSETUP\_JOIN\_DOMAIN + NETSETUP\_ACCT\_CREATE). | `number` | `3` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) Extension name. Default: DomainJoin. | `string` | `"DomainJoin"` | no |
| <a name="input_ou_path"></a> [ou\_path](#input\_ou\_path) | (Optional) The OU path where the computer account will be created. | `string` | `null` | no |
| <a name="input_restart"></a> [restart](#input\_restart) | (Optional) Restart after domain join. Default: true. | `string` | `"true"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_virtual_machine_id"></a> [virtual\_machine\_id](#input\_virtual\_machine\_id) | (Required) The ID of the Virtual Machine. DEPENDENCY: VM must exist. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | The domain that was joined. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the VM Extension. |
| <a name="output_name"></a> [name](#output\_name) | The name of the VM Extension. |
<!-- END_TF_DOCS -->