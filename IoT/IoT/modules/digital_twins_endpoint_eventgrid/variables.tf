#############################################################################
# VARIABLES DIGITAL TWINS ENDPOINT EVENTGRID
#############################################################################
variable "digital_twins_endpoint_eventgrid_name" {
  description = "value to set the digital twins endpoint eventgrid name"
  type        = string
}

variable "digital_twins_id" {
  description = "value to set the digital twins id"
  type        = string
}

variable "eventgrid_topic_endpoint" {
  description = "value to set the eventgrid topic endpoint"
  type        = string
}

variable "eventgrid_topic_primary_access_key" {
  description = "value to set the eventgrid topic primary access key"
  type        = string
}

variable "eventgrid_topic_secondary_access_key" {
  description = "value to set the eventgrid topic secondary access key"
  type        = string
}

variable "dead_letter_storage_secret" {
  description = "value to set the dead letter storage secret"
  type        = string
  default     = null
}

variable "timeouts" {
  description = "value to set the timeouts"
  type = object({
    create = optional(string)
    read   = optional(string)
    delete = optional(string)
  })
  default = null
}
