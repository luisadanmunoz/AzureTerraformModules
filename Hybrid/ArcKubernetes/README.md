# Azure Arc-enabled Kubernetes

Terraform module for registering Azure Arc-enabled Kubernetes clusters.

## Features

- Connect any Kubernetes cluster to Azure Arc
- System-assigned managed identity
- GitOps and policy management from Azure
- Centralized monitoring and governance

## Usage

```hcl
module "arc_k8s" {
  source = "path/to/Hybrid/ArcKubernetes"

  name                         = "k8s-onprem-prod-001"
  resource_group_name          = azurerm_resource_group.arc.name
  location                     = "westeurope"
  agent_public_key_certificate = base64encode(file("agent-cert.pem"))

  tags = {
    Environment = "Production"
    Cluster     = "OnPrem-K8s"
  }
}
```

## Onboarding Process

1. Create the Arc Kubernetes resource using this module
2. Install the Arc agent on your cluster using Helm or Azure CLI:
   ```bash
   az connectedk8s connect --name <cluster-name> --resource-group <rg-name>
   ```
3. The agent will connect to Azure and complete registration

## Supported Distributions

- AKS on Azure Stack HCI
- K3s
- Rancher RKE
- OpenShift
- VMware Tanzu
- Amazon EKS
- Google GKE
- Any CNCF-conformant Kubernetes

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the Arc K8s cluster | `string` | n/a | yes |
| resource_group_name | Resource group name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| agent_public_key_certificate | Base64-encoded agent certificate | `string` | n/a | yes |
| create | Whether to create the resource | `bool` | `true` | no |
| identity_type | Managed identity type | `string` | `"SystemAssigned"` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The resource ID |
| name | The resource name |
| identity | The identity block |
| principal_id | The system-assigned identity principal ID |
| agent_version | The Arc agent version |
| distribution | The K8s distribution |
| kubernetes_version | The K8s version |
| total_node_count | Total nodes in the cluster |

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
| [azurerm_arc_kubernetes_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/arc_kubernetes_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_agent_public_key_certificate"></a> [agent\_public\_key\_certificate](#input\_agent\_public\_key\_certificate) | The base64-encoded public certificate used by the agent for authentication. | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the Arc Kubernetes cluster resource. | `bool` | `true` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The type of managed identity. Only SystemAssigned is supported. | `string` | `"SystemAssigned"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the Arc cluster will be registered. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Arc-enabled Kubernetes cluster. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_agent_version"></a> [agent\_version](#output\_agent\_version) | The version of the Arc agent. |
| <a name="output_distribution"></a> [distribution](#output\_distribution) | The Kubernetes distribution running on this cluster. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Arc-enabled Kubernetes cluster. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity block of the Arc-enabled Kubernetes cluster. |
| <a name="output_kubernetes_version"></a> [kubernetes\_version](#output\_kubernetes\_version) | The Kubernetes version of the cluster. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Arc-enabled Kubernetes cluster. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The principal ID of the system-assigned managed identity. |
| <a name="output_total_node_count"></a> [total\_node\_count](#output\_total\_node\_count) | The total number of nodes in the cluster. |
<!-- END_TF_DOCS -->