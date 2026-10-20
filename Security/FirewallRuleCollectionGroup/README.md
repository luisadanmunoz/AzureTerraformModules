# Firewall Policy Rule Collection Group

Terraform module for Azure Firewall Policy Rule Collection Group.

## Features

- Application rule collections for FQDN-based filtering and web categories
- Network rule collections for IP/port-based traffic control
- NAT/DNAT rule collections for inbound traffic translation
- Priority-based ordering for rule evaluation precedence

## Usage

### Network Rules for Outbound Traffic

```hcl
module "firewall_rules_network" {
  source = "./Security/FirewallRuleCollectionGroup"

  name               = "rcg-network-outbound"
  firewall_policy_id = azurerm_firewall_policy.main.id
  priority           = 200

  network_rule_collections = [
    {
      name     = "allow-dns-ntp"
      priority = 1000
      action   = "Allow"
      rules = [
        {
          name                  = "allow-dns"
          description           = "Allow DNS queries"
          source_addresses      = ["10.0.0.0/8"]
          destination_addresses = ["168.63.129.16"]
          destination_ports     = ["53"]
          protocols             = ["UDP", "TCP"]
        },
        {
          name                  = "allow-ntp"
          description           = "Allow NTP time sync"
          source_addresses      = ["10.0.0.0/8"]
          destination_addresses = ["*"]
          destination_ports     = ["123"]
          protocols             = ["UDP"]
        }
      ]
    }
  ]
}
```

### Application Rules for Web Traffic

```hcl
module "firewall_rules_app" {
  source = "./Security/FirewallRuleCollectionGroup"

  name               = "rcg-application-web"
  firewall_policy_id = azurerm_firewall_policy.main.id
  priority           = 300

  application_rule_collections = [
    {
      name     = "allow-web-traffic"
      priority = 1000
      action   = "Allow"
      rules = [
        {
          name              = "allow-https"
          description       = "Allow HTTPS to approved FQDNs"
          source_addresses  = ["10.1.0.0/16"]
          destination_fqdns = ["*.microsoft.com", "*.azure.com"]
          protocols = [
            {
              type = "Https"
              port = 443
            }
          ]
        }
      ]
    }
  ]
}
```

### NAT Rules for Inbound DNAT

```hcl
module "firewall_rules_nat" {
  source = "./Security/FirewallRuleCollectionGroup"

  name               = "rcg-nat-inbound"
  firewall_policy_id = azurerm_firewall_policy.main.id
  priority           = 100

  nat_rule_collections = [
    {
      name     = "dnat-web-servers"
      priority = 1000
      action   = "Dnat"
      rules = [
        {
          name                = "dnat-https"
          description         = "DNAT HTTPS to internal web server"
          source_addresses    = ["*"]
          destination_address = azurerm_public_ip.firewall.ip_address
          destination_ports   = ["443"]
          protocols           = ["TCP"]
          translated_address  = "10.1.1.10"
          translated_port     = "443"
        }
      ]
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
| name | Rule Collection Group name | `string` | n/a | yes |
| firewall_policy_id | Firewall Policy ID | `string` | n/a | yes |
| priority | Group priority (100-65000) | `number` | n/a | yes |
| create | Create resources | `bool` | `true` | no |
| application_rule_collections | Application rule collections | `list(object)` | `[]` | no |
| network_rule_collections | Network rule collections | `list(object)` | `[]` | no |
| nat_rule_collections | NAT rule collections | `list(object)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Rule Collection Group ID |
| name | Rule Collection Group name |

## Best Practices

1. **Use priority ranges** - Reserve priority ranges per group type (e.g., 100-199 for NAT, 200-299 for network, 300-399 for application)
2. **Deny by default** - Place explicit deny rules at lower priority and allow rules at higher priority
3. **Least privilege** - Only allow required ports, protocols, and destinations
4. **Use IP groups** - Reference IP groups for reusable address sets across rules
5. **Separate concerns** - Create separate rule collection groups per workload or environment
