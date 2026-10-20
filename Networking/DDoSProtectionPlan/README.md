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
| [azurerm_network_ddos_protection_plan.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_ddos_protection_plan) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the DDoS Protection Plan. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name. | `string` | `"prod"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance identifier. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Azure region. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) Explicit name for the DDoS Protection Plan. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for generated name. | `string` | `"ddos"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource Group name. DEPENDENCY: Must exist. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags to assign to resources. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name. | `string` | `"shared"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the DDoS Protection Plan. |
| <a name="output_name"></a> [name](#output\_name) | The name of the DDoS Protection Plan. |
| <a name="output_virtual_network_ids"></a> [virtual\_network\_ids](#output\_virtual\_network\_ids) | List of VNet IDs associated with this plan. |
<!-- END_TF_DOCS -->