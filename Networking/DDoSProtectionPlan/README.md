# Azure DDoS Protection Plan Terraform Module

This module creates an Azure DDoS Protection Plan for protecting virtual networks against DDoS attacks.

## Features

- DDoS Protection Plan creation
- Protects up to 100 VNets per plan
- Automatic mitigation policies
- Attack analytics and reporting
- Cost protection for attacked resources

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | Must exist |

## Usage

### Create DDoS Protection Plan

```hcl
module "ddos_plan" {
  source = "../../Networking/DDoSProtectionPlan"

  resource_group_name = "rg-shared-prod-001"
  location            = "westeurope"

  name = "ddos-shared-prod-001"

  tags = {
    Environment = "Production"
    CostCenter  = "IT-Security"
  }
}
```

### Associate with VNet

```hcl
module "ddos_plan" {
  source = "../../Networking/DDoSProtectionPlan"

  resource_group_name = "rg-shared-prod-001"
  location            = "westeurope"
  name                = "ddos-shared-prod-001"
}

module "vnet" {
  source = "../../Networking/VirtualNetwork"

  resource_group_name = "rg-hub-prod-001"
  location            = "westeurope"
  name                = "vnet-hub-prod-001"
  address_space       = ["10.0.0.0/16"]

  ddos_protection_plan = {
    id     = module.ddos_plan.id
    enable = true
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls resource creation | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| location | Azure region | `string` | n/a | **yes** |
| name | Plan name | `string` | auto | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | DDoS Protection Plan ID |
| name | DDoS Protection Plan name |
| virtual_network_ids | Associated VNet IDs |

## DDoS Protection Features

| Feature | Basic (Free) | Standard |
|---------|--------------|----------|
| Always-on traffic monitoring | ✓ | ✓ |
| Automatic attack mitigation | ✓ | ✓ |
| Mitigation policies tuned for your VNet | - | ✓ |
| Attack analytics, metrics, alerts | - | ✓ |
| DDoS Rapid Response (DRR) support | - | ✓ |
| Cost protection (attack-caused scale) | - | ✓ |
| SLA | - | ✓ |

## Pricing Notes

- DDoS Standard is charged per plan plus overage
- One plan can protect up to 100 VNets
- Cross-region protection supported (same tenant)
- Includes cost protection for attack-caused resource scaling

## Security Recommendations

1. **Enable on all production VNets** with public IPs
2. **Configure alerts** for DDoS attacks
3. **Use with WAF** for comprehensive L3-L7 protection
4. **Monitor metrics** for attack patterns
5. **Plan for cost** - one plan per tenant is usually sufficient
