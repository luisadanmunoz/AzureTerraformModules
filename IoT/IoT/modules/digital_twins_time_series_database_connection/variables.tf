#############################################################################
# VARIABLES DIGITAL TWINS TIME SERIES DATABASE CONNECTION
#############################################################################
variable "digital_twins_time_series_database_connection_name" {
  description = "value to set the digital twins time series database connection name"
  type        = string
}

variable "digital_twins_id" {
  description = "value to set the digital twins id"
  type        = string
}

variable "eventhub_name" {
  description = "value to set the eventhub name"
  type        = string
}

variable "eventhub_namespace_endpoint_uri" {
  description = "value to set the eventhub namespace endpoint uri"
  type        = string
}

variable "eventhub_namespace_id" {
  description = "value to set the eventhub namespace id"
  type        = string
}

variable "eventhub_consumer_group_name" {
  description = "value to set the eventhub consumer group name"
  type        = string
  default     = null
}

variable "kusto_cluster_id" {
  description = "value to set the kusto cluster id"
  type        = string
}

variable "kusto_cluster_uri" {
  description = "value to set the kusto cluster uri"
  type        = string
}

variable "kusto_database_name" {
  description = "value to set the kusto database name"
  type        = string
}

variable "kusto_table_name" {
  description = "value to set the kusto table name"
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
