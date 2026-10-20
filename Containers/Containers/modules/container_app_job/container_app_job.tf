#############################################################################
# CONTAINER APP JOB
#############################################################################
resource "azurerm_container_app_job" "container_app_job" {
  name                         = var.container_app_job_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  container_app_environment_id = var.container_app_environment_id
  workload_profile_name        = var.workload_profile_name
  replica_retry_limit          = var.replica_retry_limit
  replica_timeout_in_seconds   = var.replica_timeout_in_seconds
  tags                         = var.tags

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value["type"]
      identity_ids = try(identity.value["identity_ids"], null)
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

  dynamic "manual_trigger_config" {
    for_each = var.manual_trigger_config != null ? [var.manual_trigger_config] : []

    content {
      parallelism              = try(manual_trigger_config.value["parallelism"], null)
      replica_completion_count = try(manual_trigger_config.value["replica_completion_count"], null)
    }
  }

  dynamic "event_trigger_config" {
    for_each = var.event_trigger_config != null ? [var.event_trigger_config] : []

    content {
      parallelism              = try(event_trigger_config.value["parallelism"], null)
      replica_completion_count = try(event_trigger_config.value["replica_completion_count"], null)

      dynamic "scale" {
        for_each = try(event_trigger_config.value["scale"], null) != null ? [event_trigger_config.value["scale"]] : []

        content {
          max_executions              = try(scale.value["max_executions"], null)
          min_executions              = try(scale.value["min_executions"], null)
          polling_interval_in_seconds = try(scale.value["polling_interval_in_seconds"], null)

          dynamic "rules" {
            for_each = try(scale.value["rules"], null) != null ? scale.value["rules"] : []

            content {
              name             = rules.value["name"]
              custom_rule_type = rules.value["custom_rule_type"]
              metadata         = rules.value["metadata"]

              dynamic "authentication" {
                for_each = try(rules.value["authentication"], null) != null ? rules.value["authentication"] : []

                content {
                  secret_name       = authentication.value["secret_name"]
                  trigger_parameter = authentication.value["trigger_parameter"]
                }
              }
            }
          }
        }
      }
    }
  }

  dynamic "schedule_trigger_config" {
    for_each = var.schedule_trigger_config != null ? [var.schedule_trigger_config] : []

    content {
      cron_expression          = schedule_trigger_config.value["cron_expression"]
      parallelism              = try(schedule_trigger_config.value["parallelism"], null)
      replica_completion_count = try(schedule_trigger_config.value["replica_completion_count"], null)
    }
  }

  template {
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
        (var.manual_trigger_config != null ? 1 : 0) +
        (var.event_trigger_config != null ? 1 : 0) +
        (var.schedule_trigger_config != null ? 1 : 0)
      ) == 1
      error_message = "Exactly one of manual_trigger_config, event_trigger_config or schedule_trigger_config must be provided."
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
