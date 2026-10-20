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
