<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_container_app_job.container_app_job](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_job) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_container_app_environment_id"></a> [container\_app\_environment\_id](#input\_container\_app\_environment\_id) | value to set the container app environment id | `string` | n/a | yes |
| <a name="input_container_app_job_name"></a> [container\_app\_job\_name](#input\_container\_app\_job\_name) | value to set the container app job name | `string` | n/a | yes |
| <a name="input_event_trigger_config"></a> [event\_trigger\_config](#input\_event\_trigger\_config) | value to set the event trigger configuration | <pre>object({<br/>    parallelism              = optional(number)<br/>    replica_completion_count = optional(number)<br/>    scale = optional(object({<br/>      max_executions              = optional(number)<br/>      min_executions              = optional(number)<br/>      polling_interval_in_seconds = optional(number)<br/>      rules = optional(list(object({<br/>        name             = string<br/>        custom_rule_type = string<br/>        metadata         = map(string)<br/>        authentication = optional(list(object({<br/>          secret_name       = string<br/>          trigger_parameter = string<br/>        })))<br/>      })))<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | value to set the identity | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | n/a | yes |
| <a name="input_manual_trigger_config"></a> [manual\_trigger\_config](#input\_manual\_trigger\_config) | value to set the manual trigger configuration | <pre>object({<br/>    parallelism              = optional(number)<br/>    replica_completion_count = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_registry"></a> [registry](#input\_registry) | value to set the registry configuration | <pre>list(object({<br/>    server               = string<br/>    identity             = optional(string)<br/>    password_secret_name = optional(string)<br/>    username             = optional(string)<br/>  }))</pre> | `null` | no |
| <a name="input_replica_retry_limit"></a> [replica\_retry\_limit](#input\_replica\_retry\_limit) | value to set the replica retry limit | `number` | `null` | no |
| <a name="input_replica_timeout_in_seconds"></a> [replica\_timeout\_in\_seconds](#input\_replica\_timeout\_in\_seconds) | value to set the replica timeout in seconds | `number` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_schedule_trigger_config"></a> [schedule\_trigger\_config](#input\_schedule\_trigger\_config) | value to set the schedule trigger configuration | <pre>object({<br/>    cron_expression          = string<br/>    parallelism              = optional(number)<br/>    replica_completion_count = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_secret"></a> [secret](#input\_secret) | value to set the secret configuration | <pre>list(object({<br/>    name                = string<br/>    identity            = optional(string)<br/>    key_vault_secret_id = optional(string)<br/>    value               = optional(string)<br/>  }))</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_template"></a> [template](#input\_template) | value to set the template | <pre>object({<br/>    init_container = optional(list(object({<br/>      name              = string<br/>      image             = string<br/>      cpu               = optional(number)<br/>      memory            = optional(string)<br/>      args              = optional(list(string))<br/>      command           = optional(list(string))<br/>      ephemeral_storage = optional(string)<br/>      env = optional(list(object({<br/>        name        = string<br/>        secret_name = optional(string)<br/>        value       = optional(string)<br/>      })))<br/>      volume_mounts = optional(list(object({<br/>        name     = string<br/>        path     = string<br/>        sub_path = optional(string)<br/>      })))<br/>    })))<br/>    container = list(object({<br/>      name              = string<br/>      image             = string<br/>      cpu               = number<br/>      memory            = string<br/>      args              = optional(list(string))<br/>      command           = optional(list(string))<br/>      ephemeral_storage = optional(string)<br/>      env = optional(list(object({<br/>        name        = string<br/>        secret_name = optional(string)<br/>        value       = optional(string)<br/>      })))<br/>      liveness_probe = optional(object({<br/>        failure_count_threshold          = optional(number)<br/>        host                             = optional(string)<br/>        initial_delay                    = optional(number)<br/>        interval_seconds                 = optional(number)<br/>        path                             = optional(string)<br/>        port                             = number<br/>        termination_grace_period_seconds = optional(number)<br/>        timeout                          = optional(number)<br/>        transport                        = string<br/>        header = optional(list(object({<br/>          name  = string<br/>          value = string<br/>        })))<br/>      }))<br/>      readiness_probe = optional(object({<br/>        failure_count_threshold = optional(number)<br/>        host                    = optional(string)<br/>        initial_delay           = optional(number)<br/>        interval_seconds        = optional(number)<br/>        path                    = optional(string)<br/>        port                    = number<br/>        success_count_threshold = optional(number)<br/>        timeout                 = optional(number)<br/>        transport               = string<br/>        header = optional(list(object({<br/>          name  = string<br/>          value = string<br/>        })))<br/>      }))<br/>      startup_probe = optional(object({<br/>        failure_count_threshold          = optional(number)<br/>        host                             = optional(string)<br/>        initial_delay                    = optional(number)<br/>        interval_seconds                 = optional(number)<br/>        path                             = optional(string)<br/>        port                             = number<br/>        termination_grace_period_seconds = optional(number)<br/>        timeout                          = optional(number)<br/>        transport                        = string<br/>        header = optional(list(object({<br/>          name  = string<br/>          value = string<br/>        })))<br/>      }))<br/>      volume_mounts = optional(list(object({<br/>        name     = string<br/>        path     = string<br/>        sub_path = optional(string)<br/>      })))<br/>    }))<br/>    volume = optional(list(object({<br/>      name          = string<br/>      storage_name  = optional(string)<br/>      storage_type  = optional(string)<br/>      mount_options = optional(string)<br/>    })))<br/>  })</pre> | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_workload_profile_name"></a> [workload\_profile\_name](#input\_workload\_profile\_name) | value to set the workload profile name | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_event_stream_endpoint"></a> [event\_stream\_endpoint](#output\_event\_stream\_endpoint) | n/a |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT CONTAINER APP JOB ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->