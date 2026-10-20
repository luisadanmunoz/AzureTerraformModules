# Firewall

Terraform module for Azure Firewall.

## Features

- Standard, Premium, and Basic SKU tiers
- Threat intelligence-based filtering (Alert, Deny, Off)
- DNS proxy for DNS resolution
- Availability zones for high availability
- Virtual WAN (vWAN) hub integration
- Forced tunneling with management IP configuration
- Firewall Policy association
- Multiple IP configurations

## Usage

### Basic Firewall with Standard Tier

```hcl
module "firewall" {
  source = "./Security/Firewall"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "myapp"
  environment = "prod"

  sku_name = "AZFW_VNet"
  sku_tier = "Standard"

  ip_configuration = [
    {
      name                 = "fw-ipconfig"
      subnet_id            = azurerm_subnet.firewall.id
      public_ip_address_id = azurerm_public_ip.firewall.id
    }
  ]
}
```

### Premium Firewall with Policy

```hcl
module "firewall" {
  source = "./Security/Firewall"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "secure"
  environment = "prod"

  sku_name           = "AZFW_VNet"
  sku_tier           = "Premium"
  firewall_policy_id = azurerm_firewall_policy.premium.id
  dns_proxy_enabled  = true
  threat_intel_mode  = "Deny"
  zones              = ["1", "2", "3"]

  ip_configuration = [
    {
      name                 = "fw-ipconfig"
      subnet_id            = azurerm_subnet.firewall.id
      public_ip_address_id = azurerm_public_ip.firewall.id
    }
  ]

  tags = {
    Environment = "Production"
    Compliance  = "Required"
  }
}
```

### Hub Firewall (vWAN)

```hcl
module "firewall" {
  source = "./Security/Firewall"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "hub"
  environment = "prod"

  sku_name          = "AZFW_Hub"
  sku_tier          = "Standard"
  threat_intel_mode = "Alert"

  virtual_hub = {
    virtual_hub_id  = azurerm_virtual_hub.main.id
    public_ip_count = 1
  }
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
| name | Firewall name | `string` | `null` | no |
| name_prefix | Name prefix | `string` | `"fw"` | no |
| workload | Workload name | `string` | `""` | no |
| environment | Environment name | `string` | `""` | no |
| instance | Instance identifier | `string` | `"001"` | no |
| create | Create resources | `bool` | `true` | no |
| sku_name | SKU name (AZFW_VNet/AZFW_Hub) | `string` | `"AZFW_VNet"` | no |
| sku_tier | SKU tier (Basic/Standard/Premium) | `string` | `"Standard"` | no |
| firewall_policy_id | Firewall Policy ID | `string` | `null` | no |
| dns_proxy_enabled | Enable DNS proxy | `bool` | `null` | no |
| threat_intel_mode | Threat intelligence mode | `string` | `"Alert"` | no |
| zones | Availability zones | `list(string)` | `[]` | no |
| ip_configuration | IP configuration blocks | `list(object)` | `[]` | no |
| management_ip_configuration | Management IP for forced tunneling | `object` | `null` | no |
| virtual_hub | Virtual Hub config for vWAN | `object` | `null` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Azure Firewall ID |
| name | Azure Firewall name |
| ip_configuration | IP configuration list |
| private_ip_address | Private IP address |
| virtual_hub | Virtual hub configuration with private and public IPs |
| resource_group_name | Resource group name |
| location | Azure region |

## Best Practices

1. **Use Firewall Policy** - Manage rules through Azure Firewall Policy for better organization and reuse
2. **Enable availability zones** - Deploy across zones 1, 2, and 3 for high availability
3. **Use Premium for TLS inspection** - Required for IDPS and TLS inspection capabilities
4. **Threat intelligence to Deny** - Set threat_intel_mode to Deny in production environments
5. **DNS proxy for FQDN rules** - Enable dns_proxy_enabled when using FQDN-based network rules
6. **Forced tunneling** - Use management_ip_configuration when routing all traffic through a next hop

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
| [azurerm_firewall.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_dns_proxy_enabled"></a> [dns\_proxy\_enabled](#input\_dns\_proxy\_enabled) | Whether DNS proxy is enabled on the Azure Firewall. | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name (dev, staging, prod) for naming convention. | `string` | `""` | no |
| <a name="input_firewall_policy_id"></a> [firewall\_policy\_id](#input\_firewall\_policy\_id) | The ID of the Firewall Policy applied to the Azure Firewall. | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | The instance identifier for naming convention. | `string` | `"001"` | no |
| <a name="input_ip_configuration"></a> [ip\_configuration](#input\_ip\_configuration) | List of IP configuration blocks for the Azure Firewall. | <pre>list(object({<br/>    name                 = string<br/>    subnet_id            = optional(string)<br/>    public_ip_address_id = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the Azure Firewall will be created. | `string` | n/a | yes |
| <a name="input_management_ip_configuration"></a> [management\_ip\_configuration](#input\_management\_ip\_configuration) | Management IP configuration block for forced tunneling. Required when forced tunneling is enabled. | <pre>object({<br/>    name                 = string<br/>    subnet_id            = string<br/>    public_ip_address_id = string<br/>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Azure Firewall. If not provided, a name will be generated. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for the Azure Firewall name. | `string` | `"fw"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the Azure Firewall will be created. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name of the Azure Firewall. Possible values are AZFW\_VNet and AZFW\_Hub. | `string` | `"AZFW_VNet"` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | The SKU tier of the Azure Firewall. Possible values are Basic, Standard, and Premium. | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources. | `map(string)` | `{}` | no |
| <a name="input_threat_intel_mode"></a> [threat\_intel\_mode](#input\_threat\_intel\_mode) | The threat intelligence mode. Possible values are Alert, Deny, and Off. | `string` | `"Alert"` | no |
| <a name="input_virtual_hub"></a> [virtual\_hub](#input\_virtual\_hub) | Virtual Hub configuration for vWAN integration (AZFW\_Hub SKU). | <pre>object({<br/>    virtual_hub_id  = string<br/>    public_ip_count = optional(number, 1)<br/>  })</pre> | `null` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name for naming convention. | `string` | `""` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | A list of availability zones where the Azure Firewall should be deployed. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Azure Firewall. |
| <a name="output_ip_configuration"></a> [ip\_configuration](#output\_ip\_configuration) | The IP configuration list of the Azure Firewall. |
| <a name="output_location"></a> [location](#output\_location) | The location of the Azure Firewall. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Azure Firewall. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The private IP address of the Azure Firewall. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The resource group name of the Azure Firewall. |
| <a name="output_virtual_hub"></a> [virtual\_hub](#output\_virtual\_hub) | The virtual hub configuration of the Azure Firewall, including private and public IP addresses. |
<!-- END_TF_DOCS -->