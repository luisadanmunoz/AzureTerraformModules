#############################################################################
# SUBNET VARIABLES
#############################################################################
variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "virtual_network_name" {
  type = string
}
variable "address_prefixes" {
  type = list(string)
}
variable "use_service_endpoints" {
  description = "Indica si los service endpoints de servicio deben habilitarse."
  type        = bool
  default     = false
}
variable "service_endpoints" {
  description = "Lista los service endpoints de servicio si usa service endpoints en valor true"
  type        = list(string)
  default     = []
}
variable "default_outbound_access_enabled" {
  type = bool
}
#############################################################################
# SUBNET DELEGATION VARIABLES
#############################################################################
variable "enable_delegation" {
  type = bool
}
variable "name_delegation" {
  type = string
}
variable "name_service_delegation" {
  type = string
}
variable "use_actions" {
  description = "Indica si los service endpoints de servicio deben habilitarse."
  type        = bool
  default     = false
}
variable "actions" {
  description = "Lista los service endpoints de servicio si usa service endpoints en valor true"
  type        = list(string)
  default     = []
}
#############################################################################
# SUBNET NSG ASSOCIATION
#############################################################################
variable "nsg_assoc" {
  type = bool
}
variable "nsg_id" {
  type = string
}
#############################################################################
# SUBNET ROUTE TABLE ASSOCIATION
#############################################################################
variable "route_table_assoc" {
  type = bool
}
variable "route_table_id" {
  type = string
}