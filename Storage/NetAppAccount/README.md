# Azure NetApp Files Account Terraform Module

This Terraform module creates an Azure NetApp Files Account, which serves as a logical container for NetApp capacity pools and volumes. The module supports optional Active Directory integration for SMB volumes and managed identity configuration.

## Features

- Create Azure NetApp Files Account with customizable naming conventions
- Optional Active Directory domain join for SMB volume support
- Managed identity support (System Assigned and User Assigned)
- Flexible tagging with default module tags
- Conditional resource creation with `create` flag

## Usage

### Basic Example

```hcl
module "netapp_account" {
  source = "../../"

  resource_group_name = "rg-netapp-prod"
  location            = "eastus"

  name_prefix = "anf"
  workload    = "data"
  environment = "prod"
  instance    = "001"

  tags = {
    Application = "DataPlatform"
    CostCenter  = "IT-12345"
  }
}
```

### Active Directory Joined Example

```hcl
module "netapp_account_ad" {
  source = "../../"

  resource_group_name = "rg-netapp-prod"
  location            = "eastus"
  name                = "anf-fileservices-prod"

  active_directory = {
    dns_servers                       = ["10.0.1.4", "10.0.1.5"]
    domain                            = "corp.contoso.com"
    username                          = "svc_netapp"
    password                          = var.ad_password
    smb_server_name                   = "ANFSMB"
    organizational_unit               = "OU=NetApp,OU=Servers,DC=corp,DC=contoso,DC=com"
    aes_encryption_enabled            = true
    ldap_signing_enabled              = true
    ldap_over_tls_enabled             = true
    server_root_ca_certificate        = file("${path.module}/certs/root-ca.crt")
    local_nfs_users_with_ldap_allowed = false
  }

  identity = {
    type = "SystemAssigned"
  }

  tags = {
    Application = "FileServices"
    Environment = "Production"
  }
}
```

### With User Assigned Identity

```hcl
module "netapp_account_uai" {
  source = "../../"

  resource_group_name = "rg-netapp-prod"
  location            = "eastus"
  name                = "anf-analytics-prod"

  identity = {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.netapp.id]
  }

  tags = {
    Application = "Analytics"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 3.70.0, < 5.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_netapp_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | The name of the resource group in which to create the NetApp Account. | `string` | n/a | yes |
| location | The Azure region where the NetApp Account will be created. | `string` | n/a | yes |
| create | Controls whether the NetApp Account should be created. | `bool` | `true` | no |
| name | The name of the NetApp Account. If provided, overrides the generated name. | `string` | `null` | no |
| name_prefix | Prefix to use for the generated NetApp Account name. | `string` | `"anf"` | no |
| workload | The workload name to include in the generated name. | `string` | `null` | no |
| environment | The environment name to include in the generated name (e.g., dev, staging, prod). | `string` | `null` | no |
| instance | The instance identifier to include in the generated name. | `string` | `null` | no |
| tags | A mapping of tags to assign to the NetApp Account. | `map(string)` | `{}` | no |
| active_directory | Active Directory configuration for the NetApp Account. Required for SMB volumes. | `object` | `null` | no |
| identity | Identity configuration for the NetApp Account. | `object` | `null` | no |

### Active Directory Object

| Attribute | Description | Type | Required |
|-----------|-------------|------|:--------:|
| dns_servers | List of DNS server IP addresses for Active Directory domain resolution. | `list(string)` | yes |
| domain | The Active Directory domain name. | `string` | yes |
| username | The username of the Active Directory domain administrator. | `string` | yes |
| password | The password of the Active Directory domain administrator. | `string` | yes |
| smb_server_name | The NetBIOS name of the SMB server. | `string` | yes |
| organizational_unit | The Organizational Unit (OU) path in Active Directory. | `string` | no |
| kerberos_ad_name | Name of the Active Directory machine account for Kerberos. | `string` | no |
| kerberos_kdc_ip | IP address of the Kerberos Key Distribution Center. | `string` | no |
| aes_encryption_enabled | Specifies whether AES encryption is enabled for SMB. | `bool` | no |
| local_nfs_users_with_ldap_allowed | Allow local NFS users with LDAP. | `bool` | no |
| ldap_over_tls_enabled | Specifies whether LDAP over TLS is enabled. | `bool` | no |
| server_root_ca_certificate | Server root CA certificate for LDAP over TLS. | `string` | no |
| ldap_signing_enabled | Specifies whether LDAP signing is enabled. | `bool` | no |

### Identity Object

| Attribute | Description | Type | Required |
|-----------|-------------|------|:--------:|
| type | The identity type. Possible values are `SystemAssigned` and `UserAssigned`. | `string` | yes |
| identity_ids | List of User Assigned Identity IDs to assign to the NetApp Account. | `list(string)` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the NetApp Account. |
| name | The name of the NetApp Account. |
| location | The Azure region where the NetApp Account is located. |

## Dependencies

- **Resource Group**: The resource group specified in `resource_group_name` must exist before creating the NetApp Account.
- **Active Directory**: If using Active Directory integration, the AD domain must be accessible from the virtual network where NetApp volumes will be deployed.
- **User Assigned Identity**: If using User Assigned identities, they must exist before being assigned to the NetApp Account.

## Notes

- Azure NetApp Files requires registering the `Microsoft.NetApp` resource provider in your subscription.
- Active Directory integration is required for creating SMB volumes.
- The Active Directory password is marked as sensitive and will not be displayed in Terraform output.
- NetApp Account names must be unique within the region and subscription.

## License

This module is released under the MIT License.

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
| [azurerm_netapp_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_active_directory"></a> [active\_directory](#input\_active\_directory) | Active Directory configuration for the NetApp Account. Required for SMB volumes.<br/>- dns\_servers: List of DNS server IP addresses for Active Directory domain resolution.<br/>- domain: The Active Directory domain name.<br/>- username: The username of the Active Directory domain administrator.<br/>- password: The password of the Active Directory domain administrator.<br/>- smb\_server\_name: The NetBIOS name of the SMB server.<br/>- organizational\_unit: The Organizational Unit (OU) path in Active Directory.<br/>- kerberos\_ad\_name: Name of the Active Directory machine account for Kerberos.<br/>- kerberos\_kdc\_ip: IP address of the Kerberos Key Distribution Center.<br/>- aes\_encryption\_enabled: Specifies whether AES encryption is enabled for SMB.<br/>- local\_nfs\_users\_with\_ldap\_allowed: Allow local NFS users with LDAP.<br/>- ldap\_over\_tls\_enabled: Specifies whether LDAP over TLS is enabled.<br/>- server\_root\_ca\_certificate: Server root CA certificate for LDAP over TLS.<br/>- ldap\_signing\_enabled: Specifies whether LDAP signing is enabled. | <pre>object({<br/>    dns_servers                       = list(string)<br/>    domain                            = string<br/>    username                          = string<br/>    password                          = string<br/>    smb_server_name                   = string<br/>    organizational_unit               = optional(string)<br/>    kerberos_ad_name                  = optional(string)<br/>    kerberos_kdc_ip                   = optional(string)<br/>    aes_encryption_enabled            = optional(bool)<br/>    local_nfs_users_with_ldap_allowed = optional(bool)<br/>    ldap_over_tls_enabled             = optional(bool)<br/>    server_root_ca_certificate        = optional(string)<br/>    ldap_signing_enabled              = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether the NetApp Account should be created. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name to include in the generated name (e.g., dev, staging, prod). | `string` | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | Identity configuration for the NetApp Account.<br/>- type: The identity type. Possible values are SystemAssigned and UserAssigned.<br/>- identity\_ids: List of User Assigned Identity IDs to assign to the NetApp Account. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | The instance identifier to include in the generated name. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the NetApp Account will be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the NetApp Account. If provided, overrides the generated name. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix to use for the generated NetApp Account name. | `string` | `"anf"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the NetApp Account. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the NetApp Account. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name to include in the generated name. | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the NetApp Account. |
| <a name="output_location"></a> [location](#output\_location) | The Azure region where the NetApp Account is located. |
| <a name="output_name"></a> [name](#output\_name) | The name of the NetApp Account. |
<!-- END_TF_DOCS -->