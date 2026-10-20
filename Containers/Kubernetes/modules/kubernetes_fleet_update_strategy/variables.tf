#############################################################################
# VARIABLES KUBERNETES FLEET UPDATE STRATEGY
#############################################################################
variable "kubernetes_fleet_update_strategy_name" {
  description = "value to set the kubernetes fleet update strategy name"
  type        = string
}

variable "kubernetes_fleet_manager_id" {
  description = "value to set the kubernetes fleet manager id"
  type        = string
}

variable "stages" {
  description = "value to set the stages"
  type = list(object({
    name                        = string
    after_stage_wait_in_seconds = optional(number)
    groups = list(object({
      name = string
    }))
  }))
}

variable "timeouts" {
  description = "value to set the timeouts"
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}
