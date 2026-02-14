################################################################################
# Azure Container Instance
################################################################################

# DEPENDENCY: Resource Group must exist
# DEPENDENCY: Subnet must exist (if using Private IP)
# DEPENDENCY: Storage Account must exist (if using Azure Files volumes)
# DEPENDENCY: Log Analytics Workspace must exist (if using diagnostics)
# DEPENDENCY: Container Registry must exist (if using private registry)

resource "azurerm_container_group" "this" {
  count = var.create ? 1 : 0

  name                = local.name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  restart_policy      = var.restart_policy
  ip_address_type     = var.ip_address_type
  dns_name_label      = var.ip_address_type == "Public" ? var.dns_name_label : null
  dns_name_label_reuse_policy = var.ip_address_type == "Public" ? var.dns_name_label_reuse_policy : null
  sku                 = var.sku
  priority            = var.priority
  subnet_ids          = var.ip_address_type == "Private" ? var.subnet_ids : null

  # DNS configuration
  dynamic "dns_config" {
    for_each = length(var.dns_servers) > 0 ? [1] : []

    content {
      nameservers = var.dns_servers
    }
  }

  # Containers
  dynamic "container" {
    for_each = var.containers

    content {
      name   = container.value.name
      image  = container.value.image
      cpu    = container.value.cpu
      memory = container.value.memory

      # Ports
      dynamic "ports" {
        for_each = container.value.ports

        content {
          port     = ports.value.port
          protocol = ports.value.protocol
        }
      }

      # Environment variables
      environment_variables        = container.value.environment_variables
      secure_environment_variables = container.value.secure_environment_variables
      commands                     = length(container.value.commands) > 0 ? container.value.commands : null

      # Volume mounts
      dynamic "volume" {
        for_each = container.value.volume_mounts

        content {
          name       = volume.value.name
          mount_path = volume.value.mount_path
          read_only  = volume.value.read_only
        }
      }

      # Liveness probe
      dynamic "liveness_probe" {
        for_each = container.value.liveness_probe != null ? [container.value.liveness_probe] : []

        content {
          exec                  = liveness_probe.value.exec
          initial_delay_seconds = liveness_probe.value.initial_delay_seconds
          period_seconds        = liveness_probe.value.period_seconds
          failure_threshold     = liveness_probe.value.failure_threshold
          success_threshold     = liveness_probe.value.success_threshold
          timeout_seconds       = liveness_probe.value.timeout_seconds

          dynamic "http_get" {
            for_each = liveness_probe.value.http_get_path != null ? [1] : []

            content {
              path   = liveness_probe.value.http_get_path
              port   = liveness_probe.value.http_get_port
              scheme = liveness_probe.value.http_get_scheme
            }
          }
        }
      }

      # Readiness probe
      dynamic "readiness_probe" {
        for_each = container.value.readiness_probe != null ? [container.value.readiness_probe] : []

        content {
          exec                  = readiness_probe.value.exec
          initial_delay_seconds = readiness_probe.value.initial_delay_seconds
          period_seconds        = readiness_probe.value.period_seconds
          failure_threshold     = readiness_probe.value.failure_threshold
          success_threshold     = readiness_probe.value.success_threshold
          timeout_seconds       = readiness_probe.value.timeout_seconds

          dynamic "http_get" {
            for_each = readiness_probe.value.http_get_path != null ? [1] : []

            content {
              path   = readiness_probe.value.http_get_path
              port   = readiness_probe.value.http_get_port
              scheme = readiness_probe.value.http_get_scheme
            }
          }
        }
      }
    }
  }

  # Init containers
  dynamic "init_container" {
    for_each = var.init_containers

    content {
      name                         = init_container.value.name
      image                        = init_container.value.image
      environment_variables        = init_container.value.environment_variables
      secure_environment_variables = init_container.value.secure_environment_variables
      commands                     = length(init_container.value.commands) > 0 ? init_container.value.commands : null

      dynamic "volume" {
        for_each = init_container.value.volume_mounts

        content {
          name       = volume.value.name
          mount_path = volume.value.mount_path
          read_only  = volume.value.read_only
        }
      }
    }
  }

  # Exposed ports
  dynamic "exposed_port" {
    for_each = var.exposed_ports

    content {
      port     = exposed_port.value.port
      protocol = exposed_port.value.protocol
    }
  }

  # Image registry credentials
  dynamic "image_registry_credential" {
    for_each = var.image_registry_credential

    content {
      server                    = image_registry_credential.value.server
      username                  = image_registry_credential.value.username
      password                  = image_registry_credential.value.password
      user_assigned_identity_id = image_registry_credential.value.user_assigned_identity_id
    }
  }

  # Identity
  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  # Diagnostics
  dynamic "diagnostics" {
    for_each = var.diagnostics != null ? [var.diagnostics] : []

    content {
      log_analytics {
        workspace_id  = diagnostics.value.log_analytics.workspace_id
        workspace_key = diagnostics.value.log_analytics.workspace_key
        log_type      = diagnostics.value.log_analytics.log_type
        metadata      = diagnostics.value.log_analytics.metadata
      }
    }
  }

  tags = local.tags
}
