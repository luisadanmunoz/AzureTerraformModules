# Azure API Management

Terraform module for creating Azure API Management Service resources.

## Features

- Full API gateway and management platform
- Multiple SKU tiers (Consumption, Developer, Basic, Standard, Premium)
- VNet integration (External and Internal modes)
- Managed identity support
- TLS/SSL configuration and cipher control
- HTTP/2 protocol support
- Conditional resource creation

## Usage

```hcl
module "apim" {
  source = "path/to/Web/APIManagement"

  name                = "apim-prod-001"
  resource_group_name = azurerm_resource_group.api.name
  location            = "eastus"
  publisher_name      = "Contoso"
  publisher_email     = "api-admin@contoso.com"
  sku_name            = "Standard_1"

  identity_type = "SystemAssigned"

  tags = {
    Environment = "Production"
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
| name | Service name | `string` | n/a | yes |
| resource_group_name | Resource group | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| publisher_name | Publisher name | `string` | n/a | yes |
| publisher_email | Publisher email | `string` | n/a | yes |
| sku_name | SKU name | `string` | `"Developer_1"` | no |
| virtual_network_type | VNet type | `string` | `"None"` | no |
| identity_type | Managed identity type | `string` | `null` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The service ID |
| name | The service name |
| gateway_url | The gateway URL |
| portal_url | The publisher portal URL |
| developer_portal_url | The developer portal URL |
| principal_id | System identity principal ID |

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
| [azurerm_api_management.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the API Management service. | `bool` | `true` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | List of User Assigned Identity IDs. | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The type of managed identity. Possible values: SystemAssigned, UserAssigned, SystemAssigned, UserAssigned. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region. | `string` | n/a | yes |
| <a name="input_min_api_version"></a> [min\_api\_version](#input\_min\_api\_version) | The minimum supported API version. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the API Management service. | `string` | n/a | yes |
| <a name="input_notification_sender_email"></a> [notification\_sender\_email](#input\_notification\_sender\_email) | The email address from which notifications will be sent. | `string` | `null` | no |
| <a name="input_protocols"></a> [protocols](#input\_protocols) | Protocol configuration for the API Management service. | <pre>object({<br/>    enable_http2 = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_publisher_email"></a> [publisher\_email](#input\_publisher\_email) | The email of the publisher. | `string` | n/a | yes |
| <a name="input_publisher_name"></a> [publisher\_name](#input\_publisher\_name) | The name of the publisher. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_security"></a> [security](#input\_security) | Security configuration. | <pre>object({<br/>    enable_backend_ssl30      = optional(bool, false)<br/>    enable_backend_tls10      = optional(bool, false)<br/>    enable_backend_tls11      = optional(bool, false)<br/>    enable_frontend_ssl30     = optional(bool, false)<br/>    enable_frontend_tls10     = optional(bool, false)<br/>    enable_frontend_tls11     = optional(bool, false)<br/>    tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = optional(bool, false)<br/>    tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = optional(bool, false)<br/>    tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = optional(bool, false)<br/>    tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = optional(bool, false)<br/>    tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = optional(bool, false)<br/>    tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = optional(bool, false)<br/>    tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = optional(bool, false)<br/>    tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = optional(bool, false)<br/>    tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = optional(bool, false)<br/>    tls_rsa_with_aes256_gcm_sha384_ciphers_enabled      = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name. Format: {tier}\_{capacity}. Possible tiers: Consumption, Developer, Basic, Standard, Premium. | `string` | `"Developer_1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resource. | `map(string)` | `{}` | no |
| <a name="input_virtual_network_subnet_id"></a> [virtual\_network\_subnet\_id](#input\_virtual\_network\_subnet\_id) | The subnet ID for VNet integration. | `string` | `null` | no |
| <a name="input_virtual_network_type"></a> [virtual\_network\_type](#input\_virtual\_network\_type) | The virtual network type. Possible values: None, External, Internal. | `string` | `"None"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_developer_portal_url"></a> [developer\_portal\_url](#output\_developer\_portal\_url) | The developer portal URL. |
| <a name="output_gateway_regional_url"></a> [gateway\_regional\_url](#output\_gateway\_regional\_url) | The regional gateway URL. |
| <a name="output_gateway_url"></a> [gateway\_url](#output\_gateway\_url) | The gateway URL of the API Management service. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the API Management service. |
| <a name="output_management_api_url"></a> [management\_api\_url](#output\_management\_api\_url) | The management API URL. |
| <a name="output_name"></a> [name](#output\_name) | The name of the API Management service. |
| <a name="output_portal_url"></a> [portal\_url](#output\_portal\_url) | The publisher portal URL. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The principal ID of the system-assigned identity. |
| <a name="output_private_ip_addresses"></a> [private\_ip\_addresses](#output\_private\_ip\_addresses) | The private IP addresses of the API Management service. |
| <a name="output_public_ip_addresses"></a> [public\_ip\_addresses](#output\_public\_ip\_addresses) | The public IP addresses of the API Management service. |
<!-- END_TF_DOCS -->