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
