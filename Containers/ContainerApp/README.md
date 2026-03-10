# ContainerApp (Azure Container Apps)

Terraform module for Azure Container Apps.

## Features

- Single or Multiple revision mode
- Auto-scaling with various scale rules (HTTP, TCP, Queue, Custom)
- Ingress with traffic splitting
- Dapr integration
- Init containers
- Volume mounts
- Health probes (liveness, readiness, startup)
- Key Vault secrets integration
- Managed identity support
- Private registry authentication

## Usage

### Basic Web App

```hcl
module "container_app" {
  source = "./Containers/ContainerApp"

  resource_group_name          = azurerm_resource_group.main.name
  container_app_environment_id = module.environment.id

  workload    = "webapp"
  environment = "dev"

  template = {
    min_replicas = 1
    max_replicas = 5

    containers = [
      {
        name   = "webapp"
        image  = "nginx:latest"
        cpu    = 0.5
        memory = "1Gi"
      }
    ]
  }

  ingress = {
    target_port      = 80
    external_enabled = true
    traffic_weight = [
      {
        latest_revision = true
        percentage      = 100
      }
    ]
  }
}
```

### API with Health Probes

```hcl
module "container_app" {
  source = "./Containers/ContainerApp"

  resource_group_name          = azurerm_resource_group.main.name
  container_app_environment_id = module.environment.id

  workload    = "api"
  environment = "prod"

  revision_mode = "Multiple"

  template = {
    min_replicas = 2
    max_replicas = 10

    containers = [
      {
        name   = "api"
        image  = "myregistry.azurecr.io/api:v1.0"
        cpu    = 1.0
        memory = "2Gi"
        env = [
          {
            name  = "APP_ENV"
            value = "production"
          },
          {
            name        = "DB_CONNECTION"
            secret_name = "db-connection"
          }
        ]
        liveness_probe = {
          transport      = "HTTP"
          port           = 8080
          path           = "/health/live"
          initial_delay  = 5
          interval_seconds = 30
        }
        readiness_probe = {
          transport      = "HTTP"
          port           = 8080
          path           = "/health/ready"
          initial_delay  = 0
          interval_seconds = 10
        }
      }
    ]

    http_scale_rule = [
      {
        name                = "http-scaling"
        concurrent_requests = 100
      }
    ]
  }

  ingress = {
    target_port      = 8080
    external_enabled = true
    transport        = "http"
    traffic_weight = [
      {
        latest_revision = true
        percentage      = 100
      }
    ]
  }

  secrets = [
    {
      name                = "db-connection"
      key_vault_secret_id = azurerm_key_vault_secret.db_connection.id
      identity            = "system"
    }
  ]

  identity = {
    type = "SystemAssigned"
  }
}
```

### With Private Registry

```hcl
module "container_app" {
  source = "./Containers/ContainerApp"

  resource_group_name          = azurerm_resource_group.main.name
  container_app_environment_id = module.environment.id

  workload    = "worker"
  environment = "prod"

  template = {
    min_replicas = 1
    max_replicas = 20

    containers = [
      {
        name   = "worker"
        image  = "myregistry.azurecr.io/worker:v1.0"
        cpu    = 2.0
        memory = "4Gi"
      }
    ]

    azure_queue_scale_rule = [
      {
        name         = "queue-scaling"
        queue_name   = "work-items"
        queue_length = 10
        authentication = [
          {
            secret_name       = "queue-connection"
            trigger_parameter = "connection"
          }
        ]
      }
    ]
  }

  registries = [
    {
      server   = "myregistry.azurecr.io"
      identity = azurerm_user_assigned_identity.acr_pull.id
    }
  ]

  identity = {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.acr_pull.id]
  }
}
```

### With Dapr

```hcl
module "container_app" {
  source = "./Containers/ContainerApp"

  resource_group_name          = azurerm_resource_group.main.name
  container_app_environment_id = module.environment.id

  workload    = "dapr-app"
  environment = "dev"

  template = {
    min_replicas = 1
    max_replicas = 5

    containers = [
      {
        name   = "app"
        image  = "myapp:latest"
        cpu    = 0.5
        memory = "1Gi"
      }
    ]
  }

  dapr = {
    app_id       = "myapp"
    app_port     = 3000
    app_protocol = "http"
  }

  ingress = {
    target_port      = 3000
    external_enabled = true
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
| container_app_environment_id | Environment ID | `string` | n/a | yes |
| template | Template configuration | `object` | n/a | yes |
| name | Container App name | `string` | `null` | no |
| workload | Workload name | `string` | `""` | no |
| environment | Environment name | `string` | `""` | no |
| revision_mode | Single or Multiple | `string` | `"Single"` | no |
| ingress | Ingress configuration | `object` | `null` | no |
| dapr | Dapr configuration | `object` | `null` | no |
| secrets | Secrets list | `list(object)` | `[]` | no |
| registries | Registry credentials | `list(object)` | `[]` | no |
| identity | Managed identity config | `object` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Container App ID |
| name | Container App name |
| latest_revision_name | Latest revision name |
| latest_revision_fqdn | Latest revision FQDN |
| outbound_ip_addresses | Outbound IP addresses |
| custom_domain_verification_id | Domain verification ID |
| identity | Identity configuration |
| principal_id | System assigned identity principal ID |

## Notes

- Container Apps require a Container App Environment
- Use Multiple revision mode for blue-green or canary deployments
- Scale rules can be combined for complex scaling scenarios
- Use managed identity for ACR authentication instead of username/password
