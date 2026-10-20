# GalleryImage

Terraform module for creating Gallery Image Definitions.

## Features

- Linux and Windows support
- Gen1 and Gen2 Hyper-V
- Trusted Launch and Confidential VM
- Recommended vCPU/memory specs
- Specialized image support

## Usage

```hcl
module "image_definition" {
  source = "./Compute/GalleryImage"

  resource_group_name = "rg-images-prod-001"
  location            = "westeurope"
  gallery_name        = module.gallery.name
  name                = "ubuntu-2204-hardened"

  os_type            = "Linux"
  hyper_v_generation = "V2"

  identifier = {
    publisher = "MyOrg"
    offer     = "Ubuntu"
    sku       = "22.04-LTS-Hardened"
  }

  trusted_launch_enabled = true
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| gallery_name | Parent gallery name | `string` | n/a | yes |
| name | Image definition name | `string` | n/a | yes |
| os_type | Linux or Windows | `string` | n/a | yes |
| identifier | Publisher/Offer/SKU | `object` | n/a | yes |
| hyper_v_generation | V1 or V2 | `string` | `"V2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Image Definition ID |
| name | Image Definition name |

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
| [azurerm_shared_image.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_accelerated_network_support_enabled"></a> [accelerated\_network\_support\_enabled](#input\_accelerated\_network\_support\_enabled) | (Optional) Enable accelerated networking. Default: false. | `bool` | `false` | no |
| <a name="input_architecture"></a> [architecture](#input\_architecture) | (Optional) CPU architecture. Values: x64, Arm64. Default: x64. | `string` | `"x64"` | no |
| <a name="input_confidential_vm_enabled"></a> [confidential\_vm\_enabled](#input\_confidential\_vm\_enabled) | (Optional) Enable Confidential VM. Default: false. | `bool` | `false` | no |
| <a name="input_confidential_vm_supported"></a> [confidential\_vm\_supported](#input\_confidential\_vm\_supported) | (Optional) Is Confidential VM supported. Default: false. | `bool` | `false` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Gallery Image Definition. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description of the Gallery Image Definition. | `string` | `null` | no |
| <a name="input_eula"></a> [eula](#input\_eula) | (Optional) The End User License Agreement for the Gallery Image. | `string` | `null` | no |
| <a name="input_gallery_name"></a> [gallery\_name](#input\_gallery\_name) | (Required) The name of the Shared Image Gallery. DEPENDENCY: Gallery must exist. | `string` | n/a | yes |
| <a name="input_hyper_v_generation"></a> [hyper\_v\_generation](#input\_hyper\_v\_generation) | (Optional) The Hyper-V generation. Values: V1, V2. Default: V2. | `string` | `"V2"` | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | (Required) Image identifier.<br/>- publisher: Image publisher name.<br/>- offer: Image offer name.<br/>- sku: Image SKU name. | <pre>object({<br/>    publisher = string<br/>    offer     = string<br/>    sku       = string<br/>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Image should exist. | `string` | n/a | yes |
| <a name="input_max_recommended_memory_in_gb"></a> [max\_recommended\_memory\_in\_gb](#input\_max\_recommended\_memory\_in\_gb) | (Optional) Maximum recommended memory in GB. | `number` | `null` | no |
| <a name="input_max_recommended_vcpu_count"></a> [max\_recommended\_vcpu\_count](#input\_max\_recommended\_vcpu\_count) | (Optional) Maximum recommended vCPU count. | `number` | `null` | no |
| <a name="input_min_recommended_memory_in_gb"></a> [min\_recommended\_memory\_in\_gb](#input\_min\_recommended\_memory\_in\_gb) | (Optional) Minimum recommended memory in GB. | `number` | `null` | no |
| <a name="input_min_recommended_vcpu_count"></a> [min\_recommended\_vcpu\_count](#input\_min\_recommended\_vcpu\_count) | (Optional) Minimum recommended vCPU count. | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Gallery Image Definition. | `string` | n/a | yes |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | (Required) The OS type. Values: Linux, Windows. | `string` | n/a | yes |
| <a name="input_privacy_statement_uri"></a> [privacy\_statement\_uri](#input\_privacy\_statement\_uri) | (Optional) The URI of the privacy statement. | `string` | `null` | no |
| <a name="input_release_note_uri"></a> [release\_note\_uri](#input\_release\_note\_uri) | (Optional) The URI of the release notes. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_specialized"></a> [specialized](#input\_specialized) | (Optional) Is the image specialized. Default: false. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_trusted_launch_enabled"></a> [trusted\_launch\_enabled](#input\_trusted\_launch\_enabled) | (Optional) Enable Trusted Launch. Default: false. | `bool` | `false` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_gallery_name"></a> [gallery\_name](#output\_gallery\_name) | The name of the parent Gallery. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Gallery Image Definition. |
| <a name="output_identifier"></a> [identifier](#output\_identifier) | The image identifier. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Gallery Image Definition. |
<!-- END_TF_DOCS -->