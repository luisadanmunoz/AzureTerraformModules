################################################################################
# Example: Azure Arc-enabled Kubernetes
################################################################################

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.70.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "arc" {
  name     = "rg-arc-kubernetes"
  location = "westeurope"
}

# Generate agent certificate (for demo purposes)
resource "tls_private_key" "agent" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_self_signed_cert" "agent" {
  private_key_pem = tls_private_key.agent.private_key_pem

  subject {
    common_name = "arc-agent"
  }

  validity_period_hours = 8760

  allowed_uses = [
    "digital_signature",
    "client_auth",
  ]
}

################################################################################
# Arc-enabled Kubernetes Cluster
################################################################################

module "arc_k8s" {
  source = "../../"

  name                         = "k8s-onprem-prod-001"
  resource_group_name          = azurerm_resource_group.arc.name
  location                     = azurerm_resource_group.arc.location
  agent_public_key_certificate = base64encode(tls_self_signed_cert.agent.cert_pem)

  tags = {
    Environment  = "Production"
    Distribution = "K3s"
    Location     = "Datacenter-1"
  }
}

################################################################################
# Outputs
################################################################################

output "cluster_id" {
  value = module.arc_k8s.id
}

output "cluster_principal_id" {
  value = module.arc_k8s.principal_id
}
