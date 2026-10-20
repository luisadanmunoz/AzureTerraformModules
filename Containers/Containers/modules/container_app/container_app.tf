#############################################################################
# CONTAINER APP
#############################################################################
resource "azurerm_container_app" "container_app" {
  name                         = var.container_app_name
  container_app_environment_id = var.container_app_environment_id
  resource_group_name          = var.resource_group_name
  revision_mode                = var.revision_mode
  workload_profile_name        = var.workload_profile_name
  max_inactive_revisions       = var.max_inactive_revisions
  tags                         = var.tags

  dynamic "dapr" {
    for_each = var.dapr != null ? [var.dapr] : []

    content {
      app_id       = dapr.value["app_id"]
      app_port     = try(dapr.value["app_port"], null)
      app_protocol = try(dapr.value["app_protocol"], null)
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value["type"]
      identity_ids = try(identity.value["identity_ids"], null)
    }
  }

  dynamic "ingress" {
    for_each = var.ingress != null ? [var.ingress] : []

    content {
      allow_insecure_connections = try(ingress.value["allow_insecure_connections"], null)
      client_certificate_mode    = try(ingress.value["client_certificate_mode"], null)
      external_enabled           = try(ingress.value["external_enabled"], null)
      target_port                = ingress.value["target_port"]
      exposed_port               = try(ingress.value["exposed_port"], null)
      transport                  = try(ingress.value["transport"], null)

      dynamic "cors" {
        for_each = try(ingress.value["cors"], null) != null ? [ingress.value["cors"]] : []

        content {
          allow_credentials_enabled = try(cors.value["allow_credentials_enabled"], null)
          allowed_headers           = try(cors.value["allowed_headers"], null)
          allowed_methods           = try(cors.value["allowed_methods"], null)
          allowed_origins           = cors.value["allowed_origins"]
          exposed_headers           = try(cors.value["exposed_headers"], null)
          max_age_in_seconds        = try(cors.value["max_age_in_seconds"], null)
        }
      }

      dynamic "ip_security_restriction" {
        for_each = try(ingress.value["ip_security_restriction"], null) != null ? ingress.value["ip_security_restriction"] : []

        content {
          action           = ip_security_restriction.value["action"]
          description      = try(ip_security_restriction.value["description"], null)
          ip_address_range = ip_security_restriction.value["ip_address_range"]
          name             = ip_security_restriction.value["name"]
        }
      }

      dynamic "traffic_weight" {
        for_each = ingress.value["traffic_weight"]

        content {
          label           = try(traffic_weight.value["label"], null)
          latest_revision = try(traffic_weight.value["latest_revision"], null)
          percentage      = traffic_weight.value["percentage"]
          revision_suffix = try(traffic_weight.value["revision_suffix"], null)
        }
      }
    }
  }

  dynamic "registry" {
    for_each = var.registry != null ? var.registry : []

    content {
      server               = registry.value["server"]
      identity             = try(registry.value["identity"], null)
      password_secret_name = try(registry.value["password_secret_name"], null)
      username             = try(registry.value["username"], null)
    }
  }

  dynamic "secret" {
    for_each = var.secret != null ? var.secret : []

    content {
      name                = secret.value["name"]
      identity            = try(secret.value["identity"], null)
      key_vault_secret_id = try(secret.value["key_vault_secret_id"], null)
      value               = try(secret.value["value"], null)
    }
  }

  template {
    min_replicas                     = try(var.template["min_replicas"], null)
    max_replicas                     = try(var.template["max_replicas"], null)
    cooldown_period_in_seconds       = try(var.template["cooldown_period_in_seconds"], null)
    polling_interval_in_seconds      = try(var.template["polling_interval_in_seconds"], null)
    revision_suffix                  = try(var.template["revision_suffix"], null)
    termination_grace_period_seconds = try(var.template["termination_grace_period_seconds"], null)

    dynamic "azure_queue_scale_rule" {
      for_each = try(var.template["azure_queue_scale_rule"], null) != null ? var.template["azure_queue_scale_rule"] : []

      content {
        name         = azure_queue_scale_rule.value["name"]
        queue_length = azure_queue_scale_rule.value["queue_length"]
        queue_name   = azure_queue_scale_rule.value["queue_name"]

        dynamic "authentication" {
          for_each = azure_queue_scale_rule.value["authentication"]

          content {
            secret_name       = authentication.value["secret_name"]
            trigger_parameter = authentication.value["trigger_parameter"]
          }
        }
      }
    }

    dynamic "custom_scale_rule" {
      for_each = try(var.template["custom_scale_rule"], null) != null ? var.template["custom_scale_rule"] : []

      content {
        name             = custom_scale_rule.value["name"]
        custom_rule_type = custom_scale_rule.value["custom_rule_type"]
        metadata         = custom_scale_rule.value["metadata"]

        dynamic "authentication" {
          for_each = try(custom_scale_rule.value["authentication"], null) != null ? custom_scale_rule.value["authentication"] : []

          content {
            secret_name       = authentication.value["secret_name"]
            trigger_parameter = authentication.value["trigger_parameter"]
          }
        }
      }
    }

    dynamic "http_scale_rule" {
      for_each = try(var.template["http_scale_rule"], null) != null ? var.template["http_scale_rule"] : []

      content {
        name                = http_scale_rule.value["name"]
        concurrent_requests = http_scale_rule.value["concurrent_requests"]

        dynamic "authentication" {
          for_each = try(http_scale_rule.value["authentication"], null) != null ? http_scale_rule.value["authentication"] : []

          content {
            secret_name       = authentication.value["secret_name"]
            trigger_parameter = authentication.value["trigger_parameter"]
          }
        }
      }
    }

    dynamic "tcp_scale_rule" {
      for_each = try(var.template["tcp_scale_rule"], null) != null ? var.template["tcp_scale_rule"] : []

      content {
        name                = tcp_scale_rule.value["name"]
        concurrent_requests = tcp_scale_rule.value["concurrent_requests"]

        dynamic "authentication" {
          for_each = try(tcp_scale_rule.value["authentication"], null) != null ? tcp_scale_rule.value["authentication"] : []

          content {
            secret_name       = authentication.value["secret_name"]
            trigger_parameter = authentication.value["trigger_parameter"]
          }
        }
      }
    }

    dynamic "init_container" {
      for_each = try(var.template["init_container"], null) != null ? var.template["init_container"] : []

      content {
        name              = init_container.value["name"]
        image             = init_container.value["image"]
        cpu               = try(init_container.value["cpu"], null)
        memory            = try(init_container.value["memory"], null)
        args              = try(init_container.value["args"], null)
        command           = try(init_container.value["command"], null)
        ephemeral_storage = try(init_container.value["ephemeral_storage"], null)

        dynamic "env" {
          for_each = try(init_container.value["env"], null) != null ? init_container.value["env"] : []

          content {
            name        = env.value["name"]
            secret_name = try(env.value["secret_name"], null)
            value       = try(env.value["value"], null)
          }
        }

        dynamic "volume_mounts" {
          for_each = try(init_container.value["volume_mounts"], null) != null ? init_container.value["volume_mounts"] : []

          content {
            name     = volume_mounts.value["name"]
            path     = volume_mounts.value["path"]
            sub_path = try(volume_mounts.value["sub_path"], null)
          }
        }
      }
    }

    dynamic "container" {
      for_each = var.template["container"]

      content {
        name              = container.value["name"]
        image             = container.value["image"]
        cpu               = container.value["cpu"]
        memory            = container.value["memory"]
        args              = try(container.value["args"], null)
        command           = try(container.value["command"], null)
        ephemeral_storage = try(container.value["ephemeral_storage"], null)

        dynamic "env" {
          for_each = try(container.value["env"], null) != null ? container.value["env"] : []

          content {
            name        = env.value["name"]
            secret_name = try(env.value["secret_name"], null)
            value       = try(env.value["value"], null)
          }
        }

        dynamic "liveness_probe" {
          for_each = try(container.value["liveness_probe"], null) != null ? [container.value["liveness_probe"]] : []

          content {
            failure_count_threshold          = try(liveness_probe.value["failure_count_threshold"], null)
            host                             = try(liveness_probe.value["host"], null)
            initial_delay                    = try(liveness_probe.value["initial_delay"], null)
            interval_seconds                 = try(liveness_probe.value["interval_seconds"], null)
            path                             = try(liveness_probe.value["path"], null)
            port                             = liveness_probe.value["port"]
            termination_grace_period_seconds = try(liveness_probe.value["termination_grace_period_seconds"], null)
            timeout                          = try(liveness_probe.value["timeout"], null)
            transport                        = liveness_probe.value["transport"]

            dynamic "header" {
              for_each = try(liveness_probe.value["header"], null) != null ? liveness_probe.value["header"] : []

              content {
                name  = header.value["name"]
                value = header.value["value"]
              }
            }
          }
        }

        dynamic "readiness_probe" {
          for_each = try(container.value["readiness_probe"], null) != null ? [container.value["readiness_probe"]] : []

          content {
            failure_count_threshold = try(readiness_probe.value["failure_count_threshold"], null)
            host                    = try(readiness_probe.value["host"], null)
            initial_delay           = try(readiness_probe.value["initial_delay"], null)
            interval_seconds        = try(readiness_probe.value["interval_seconds"], null)
            path                    = try(readiness_probe.value["path"], null)
            port                    = readiness_probe.value["port"]
            success_count_threshold = try(readiness_probe.value["success_count_threshold"], null)
            timeout                 = try(readiness_probe.value["timeout"], null)
            transport               = readiness_probe.value["transport"]

            dynamic "header" {
              for_each = try(readiness_probe.value["header"], null) != null ? readiness_probe.value["header"] : []

              content {
                name  = header.value["name"]
                value = header.value["value"]
              }
            }
          }
        }

        dynamic "startup_probe" {
          for_each = try(container.value["startup_probe"], null) != null ? [container.value["startup_probe"]] : []

          content {
            failure_count_threshold          = try(startup_probe.value["failure_count_threshold"], null)
            host                             = try(startup_probe.value["host"], null)
            initial_delay                    = try(startup_probe.value["initial_delay"], null)
            interval_seconds                 = try(startup_probe.value["interval_seconds"], null)
            path                             = try(startup_probe.value["path"], null)
            port                             = startup_probe.value["port"]
            termination_grace_period_seconds = try(startup_probe.value["termination_grace_period_seconds"], null)
            timeout                          = try(startup_probe.value["timeout"], null)
            transport                        = startup_probe.value["transport"]

            dynamic "header" {
              for_each = try(startup_probe.value["header"], null) != null ? startup_probe.value["header"] : []

              content {
                name  = header.value["name"]
                value = header.value["value"]
              }
            }
          }
        }

        dynamic "volume_mounts" {
          for_each = try(container.value["volume_mounts"], null) != null ? container.value["volume_mounts"] : []

          content {
            name     = volume_mounts.value["name"]
            path     = volume_mounts.value["path"]
            sub_path = try(volume_mounts.value["sub_path"], null)
          }
        }
      }
    }

    dynamic "volume" {
      for_each = try(var.template["volume"], null) != null ? var.template["volume"] : []

      content {
        name          = volume.value["name"]
        storage_name  = try(volume.value["storage_name"], null)
        storage_type  = try(volume.value["storage_type"], null)
        mount_options = try(volume.value["mount_options"], null)
      }
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      update = try(timeouts.value["update"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }

  lifecycle {
    precondition {
      condition     = length(var.template["container"]) > 0
      error_message = "template.container must contain at least one container block."
    }

    precondition {
      condition = (
        var.ingress == null ||
        sum([for traffic_weight in var.ingress["traffic_weight"] : traffic_weight["percentage"]]) == 100
      )
      error_message = "The ingress traffic_weight percentages must sum exactly to 100."
    }

    precondition {
      condition = (
        var.ingress == null ||
        try(var.ingress["transport"], null) != "tcp" ||
        try(var.ingress["exposed_port"], null) != null
      )
      error_message = "exposed_port is required when ingress.transport is tcp."
    }

    precondition {
      condition = alltrue([
        for registry in coalesce(var.registry, []) : (
          (try(registry["identity"], null) != null && try(registry["username"], null) == null && try(registry["password_secret_name"], null) == null) ||
          (try(registry["identity"], null) == null && try(registry["username"], null) != null && try(registry["password_secret_name"], null) != null)
        )
      ])
      error_message = "Each registry block must use either identity or username/password_secret_name."
    }

    precondition {
      condition = alltrue([
        for secret in coalesce(var.secret, []) : (
          try(secret["identity"], null) == null ||
          try(secret["key_vault_secret_id"], null) != null
        )
      ])
      error_message = "When a secret identity is provided, key_vault_secret_id must also be provided."
    }
  }
}
