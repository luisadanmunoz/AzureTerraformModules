################################################################################
# Azure Container App
################################################################################

# DEPENDENCY: Container App Environment must exist
# DEPENDENCY: Container Registry must exist (if using private registry)
# DEPENDENCY: Key Vault must exist (if using Key Vault secrets)
# DEPENDENCY: User Assigned Identity must exist (if using UserAssigned identity)

resource "azurerm_container_app" "this" {
  count = var.create ? 1 : 0

  name                         = local.name
  resource_group_name          = var.resource_group_name
  container_app_environment_id = var.container_app_environment_id
  revision_mode                = var.revision_mode
  workload_profile_name        = var.workload_profile_name

  # Template
  template {
    min_replicas    = var.template.min_replicas
    max_replicas    = var.template.max_replicas
    revision_suffix = var.template.revision_suffix

    # Containers
    dynamic "container" {
      for_each = var.template.containers

      content {
        name    = container.value.name
        image   = container.value.image
        cpu     = container.value.cpu
        memory  = container.value.memory
        args    = length(container.value.args) > 0 ? container.value.args : null
        command = length(container.value.command) > 0 ? container.value.command : null

        # Environment variables
        dynamic "env" {
          for_each = container.value.env

          content {
            name        = env.value.name
            value       = env.value.value
            secret_name = env.value.secret_name
          }
        }

        # Liveness probe
        dynamic "liveness_probe" {
          for_each = container.value.liveness_probe != null ? [container.value.liveness_probe] : []

          content {
            transport               = liveness_probe.value.transport
            port                    = liveness_probe.value.port
            path                    = liveness_probe.value.path
            host                    = liveness_probe.value.host
            initial_delay           = liveness_probe.value.initial_delay
            interval_seconds        = liveness_probe.value.interval_seconds
            timeout                 = liveness_probe.value.timeout
            failure_count_threshold = liveness_probe.value.failure_count_threshold

            dynamic "header" {
              for_each = liveness_probe.value.header

              content {
                name  = header.value.name
                value = header.value.value
              }
            }
          }
        }

        # Readiness probe
        dynamic "readiness_probe" {
          for_each = container.value.readiness_probe != null ? [container.value.readiness_probe] : []

          content {
            transport               = readiness_probe.value.transport
            port                    = readiness_probe.value.port
            path                    = readiness_probe.value.path
            host                    = readiness_probe.value.host
            initial_delay           = readiness_probe.value.initial_delay
            interval_seconds        = readiness_probe.value.interval_seconds
            timeout                 = readiness_probe.value.timeout
            failure_count_threshold = readiness_probe.value.failure_count_threshold
            success_count_threshold = readiness_probe.value.success_count_threshold

            dynamic "header" {
              for_each = readiness_probe.value.header

              content {
                name  = header.value.name
                value = header.value.value
              }
            }
          }
        }

        # Startup probe
        dynamic "startup_probe" {
          for_each = container.value.startup_probe != null ? [container.value.startup_probe] : []

          content {
            transport               = startup_probe.value.transport
            port                    = startup_probe.value.port
            path                    = startup_probe.value.path
            host                    = startup_probe.value.host
            initial_delay           = startup_probe.value.initial_delay
            interval_seconds        = startup_probe.value.interval_seconds
            timeout                 = startup_probe.value.timeout
            failure_count_threshold = startup_probe.value.failure_count_threshold

            dynamic "header" {
              for_each = startup_probe.value.header

              content {
                name  = header.value.name
                value = header.value.value
              }
            }
          }
        }

        # Volume mounts
        dynamic "volume_mounts" {
          for_each = container.value.volume_mounts

          content {
            name = volume_mounts.value.name
            path = volume_mounts.value.path
          }
        }
      }
    }

    # Init containers
    dynamic "init_container" {
      for_each = var.template.init_containers

      content {
        name    = init_container.value.name
        image   = init_container.value.image
        cpu     = init_container.value.cpu
        memory  = init_container.value.memory
        args    = length(init_container.value.args) > 0 ? init_container.value.args : null
        command = length(init_container.value.command) > 0 ? init_container.value.command : null

        dynamic "env" {
          for_each = init_container.value.env

          content {
            name        = env.value.name
            value       = env.value.value
            secret_name = env.value.secret_name
          }
        }

        dynamic "volume_mounts" {
          for_each = init_container.value.volume_mounts

          content {
            name = volume_mounts.value.name
            path = volume_mounts.value.path
          }
        }
      }
    }

    # Volumes
    dynamic "volume" {
      for_each = var.template.volumes

      content {
        name         = volume.value.name
        storage_type = volume.value.storage_type
        storage_name = volume.value.storage_name
      }
    }

    # Azure Queue scale rules
    dynamic "azure_queue_scale_rule" {
      for_each = var.template.azure_queue_scale_rule

      content {
        name         = azure_queue_scale_rule.value.name
        queue_name   = azure_queue_scale_rule.value.queue_name
        queue_length = azure_queue_scale_rule.value.queue_length

        dynamic "authentication" {
          for_each = azure_queue_scale_rule.value.authentication

          content {
            secret_name       = authentication.value.secret_name
            trigger_parameter = authentication.value.trigger_parameter
          }
        }
      }
    }

    # Custom scale rules
    dynamic "custom_scale_rule" {
      for_each = var.template.custom_scale_rule

      content {
        name             = custom_scale_rule.value.name
        custom_rule_type = custom_scale_rule.value.custom_rule_type
        metadata         = custom_scale_rule.value.metadata

        dynamic "authentication" {
          for_each = custom_scale_rule.value.authentication

          content {
            secret_name       = authentication.value.secret_name
            trigger_parameter = authentication.value.trigger_parameter
          }
        }
      }
    }

    # HTTP scale rules
    dynamic "http_scale_rule" {
      for_each = var.template.http_scale_rule

      content {
        name                = http_scale_rule.value.name
        concurrent_requests = http_scale_rule.value.concurrent_requests

        dynamic "authentication" {
          for_each = http_scale_rule.value.authentication

          content {
            secret_name       = authentication.value.secret_name
            trigger_parameter = authentication.value.trigger_parameter
          }
        }
      }
    }

    # TCP scale rules
    dynamic "tcp_scale_rule" {
      for_each = var.template.tcp_scale_rule

      content {
        name                = tcp_scale_rule.value.name
        concurrent_requests = tcp_scale_rule.value.concurrent_requests

        dynamic "authentication" {
          for_each = tcp_scale_rule.value.authentication

          content {
            secret_name       = authentication.value.secret_name
            trigger_parameter = authentication.value.trigger_parameter
          }
        }
      }
    }
  }

  # Ingress
  dynamic "ingress" {
    for_each = var.ingress != null ? [var.ingress] : []

    content {
      allow_insecure_connections = ingress.value.allow_insecure_connections
      external_enabled           = ingress.value.external_enabled
      target_port                = ingress.value.target_port
      exposed_port               = ingress.value.exposed_port
      transport                  = ingress.value.transport

      dynamic "traffic_weight" {
        for_each = ingress.value.traffic_weight

        content {
          label           = traffic_weight.value.label
          latest_revision = traffic_weight.value.latest_revision
          revision_suffix = traffic_weight.value.revision_suffix
          percentage      = traffic_weight.value.percentage
        }
      }

      dynamic "ip_security_restriction" {
        for_each = ingress.value.ip_security_restriction != null ? ingress.value.ip_security_restriction : []

        content {
          name             = ip_security_restriction.value.name
          action           = ip_security_restriction.value.action
          ip_address_range = ip_security_restriction.value.ip_address_range
          description      = ip_security_restriction.value.description
        }
      }
    }
  }

  # Dapr
  dynamic "dapr" {
    for_each = var.dapr != null ? [var.dapr] : []

    content {
      app_id       = dapr.value.app_id
      app_port     = dapr.value.app_port
      app_protocol = dapr.value.app_protocol
    }
  }

  # Secrets
  dynamic "secret" {
    for_each = var.secrets

    content {
      name                = secret.value.name
      value               = secret.value.value
      identity            = secret.value.identity
      key_vault_secret_id = secret.value.key_vault_secret_id
    }
  }

  # Registry
  dynamic "registry" {
    for_each = var.registries

    content {
      server               = registry.value.server
      username             = registry.value.username
      password_secret_name = registry.value.password_secret_name
      identity             = registry.value.identity
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

  tags = local.tags
}
