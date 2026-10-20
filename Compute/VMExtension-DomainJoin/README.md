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
