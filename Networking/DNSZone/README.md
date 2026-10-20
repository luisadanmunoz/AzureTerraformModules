# Azure Public DNS Zone Terraform Module

This module creates an Azure DNS Zone (public) with support for all DNS record types.

## Features

- Public DNS Zone for internet-facing domains
- All DNS record types: A, AAAA, CAA, CNAME, MX, NS, PTR, SRV, TXT
- SOA record customization
- Automatic name server assignment

## Usage

### Basic DNS Zone

```hcl
module "dns_zone" {
  source = "../../Networking/DNSZone"

  resource_group_name = "rg-dns-prod-001"
  name                = "contoso.com"
}
```

### With Records

```hcl
module "dns_zone" {
  source = "../../Networking/DNSZone"

  resource_group_name = "rg-dns-prod-001"
  name                = "contoso.com"

  a_records = {
    "www"  = { records = ["20.50.1.1"] }
    "api"  = { records = ["20.50.1.2"], ttl = 60 }
  }

  cname_records = {
    "mail" = { record = "mail.outlook.com" }
  }

  mx_records = {
    "@" = {
      records = [
        { preference = 10, exchange = "mail1.contoso.com." },
        { preference = 20, exchange = "mail2.contoso.com." }
      ]
    }
  }

  txt_records = {
    "@" = { records = ["v=spf1 include:spf.protection.outlook.com -all"] }
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| name | DNS Zone name | `string` | n/a | **yes** |
| a_records | A records | `map(object({...}))` | `{}` | no |
| cname_records | CNAME records | `map(object({...}))` | `{}` | no |
| mx_records | MX records | `map(object({...}))` | `{}` | no |
| txt_records | TXT records | `map(object({...}))` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | DNS Zone ID |
| name | DNS Zone name |
| name_servers | Name servers for delegation |

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
| [azurerm_dns_a_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_aaaa_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_aaaa_record) | resource |
| [azurerm_dns_caa_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_caa_record) | resource |
| [azurerm_dns_cname_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_mx_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_mx_record) | resource |
| [azurerm_dns_ns_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ptr_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ptr_record) | resource |
| [azurerm_dns_srv_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_srv_record) | resource |
| [azurerm_dns_txt_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_a_records"></a> [a\_records](#input\_a\_records) | (Optional) Map of A records. | <pre>map(object({<br/>    ttl     = optional(number, 300)<br/>    records = list(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_aaaa_records"></a> [aaaa\_records](#input\_aaaa\_records) | (Optional) Map of AAAA records. | <pre>map(object({<br/>    ttl     = optional(number, 300)<br/>    records = list(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_caa_records"></a> [caa\_records](#input\_caa\_records) | (Optional) Map of CAA records. | <pre>map(object({<br/>    ttl = optional(number, 300)<br/>    records = list(object({<br/>      flags = number<br/>      tag   = string<br/>      value = string<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_cname_records"></a> [cname\_records](#input\_cname\_records) | (Optional) Map of CNAME records. | <pre>map(object({<br/>    ttl    = optional(number, 300)<br/>    record = string<br/>  }))</pre> | `{}` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the DNS Zone. | `bool` | `true` | no |
| <a name="input_mx_records"></a> [mx\_records](#input\_mx\_records) | (Optional) Map of MX records. | <pre>map(object({<br/>    ttl = optional(number, 300)<br/>    records = list(object({<br/>      preference = number<br/>      exchange   = string<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the DNS Zone (e.g., 'contoso.com'). | `string` | n/a | yes |
| <a name="input_ns_records"></a> [ns\_records](#input\_ns\_records) | (Optional) Map of NS records (besides zone apex). | <pre>map(object({<br/>    ttl     = optional(number, 172800)<br/>    records = list(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_ptr_records"></a> [ptr\_records](#input\_ptr\_records) | (Optional) Map of PTR records. | <pre>map(object({<br/>    ttl     = optional(number, 300)<br/>    records = list(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource Group name. DEPENDENCY: Must exist. | `string` | n/a | yes |
| <a name="input_soa_record"></a> [soa\_record](#input\_soa\_record) | (Optional) SOA record configuration.<br/><br/>Attributes:<br/>  - email: Contact email (format: hostmaster.domain.com).<br/>  - expire\_time: Expire time in seconds.<br/>  - minimum\_ttl: Minimum TTL.<br/>  - refresh\_time: Refresh time.<br/>  - retry\_time: Retry time.<br/>  - ttl: SOA record TTL. | <pre>object({<br/>    email        = string<br/>    expire_time  = optional(number, 2419200)<br/>    minimum_ttl  = optional(number, 300)<br/>    refresh_time = optional(number, 3600)<br/>    retry_time   = optional(number, 300)<br/>    ttl          = optional(number, 3600)<br/>  })</pre> | `null` | no |
| <a name="input_srv_records"></a> [srv\_records](#input\_srv\_records) | (Optional) Map of SRV records. | <pre>map(object({<br/>    ttl = optional(number, 300)<br/>    records = list(object({<br/>      priority = number<br/>      weight   = number<br/>      port     = number<br/>      target   = string<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags to assign to resources. | `map(string)` | `{}` | no |
| <a name="input_txt_records"></a> [txt\_records](#input\_txt\_records) | (Optional) Map of TXT records. | <pre>map(object({<br/>    ttl     = optional(number, 300)<br/>    records = list(string)<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_a_record_ids"></a> [a\_record\_ids](#output\_a\_record\_ids) | Map of A record IDs. |
| <a name="output_cname_record_ids"></a> [cname\_record\_ids](#output\_cname\_record\_ids) | Map of CNAME record IDs. |
| <a name="output_id"></a> [id](#output\_id) | The DNS Zone ID. |
| <a name="output_name"></a> [name](#output\_name) | The DNS Zone name. |
| <a name="output_name_servers"></a> [name\_servers](#output\_name\_servers) | The name servers for this DNS Zone. |
| <a name="output_number_of_record_sets"></a> [number\_of\_record\_sets](#output\_number\_of\_record\_sets) | The number of record sets. |
<!-- END_TF_DOCS -->