#############################################################################
# VARIABLES SUBNET
#############################################################################
variable "subnet_name" {
  description = "value to set the subnet name"
  type        = string
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "virtual_network_name" {
  description = "value to set the virtual network name"
  type        = string
}

variable "address_prefixes" {
  description = "value to set the address prefixes"
  type        = list(string)
}

variable "service_endpoints" {
  description = "value to set the service endpoints"
  type        = list(string)
  default     = []
}

variable "service_endpoint_policy_ids" {
  description = "value to set the service endpoint policy ids"
  type        = list(string)
  default     = []
}

variable "private_endpoint_network_policies" {
  description = "value to set the private endpoint network policies"
  type        = string
  default     = null
}

variable "private_link_service_network_policies" {
  description = "value to set the private link service network policies"
  type        = bool
  default     = null
}

variable "delegations" {
  description = "value to set the delegations"
  type = list(object({
    name = string
    service_delegation = object({
      name    = string
      actions = optional(list(string))
    })
  }))
  default = []
}

variable "associate_nsg" {
  description = "value to indicate nsg association"
  type        = bool
  default     = false
}

variable "nsg_id" {
  description = "value to set the network security group id"
  type        = string
  default     = null
}

variable "associate_route_table" {
  description = "value to indicate route table association"
  type        = bool
  default     = false
}

variable "route_table_id" {
  description = "value to set the route table id"
  type        = string
  default     = null
}

variable "associate_nat_gateway" {
  description = "value to indicate nat gateway association"
  type        = bool
  default     = false
}

variable "nat_gateway_id" {
  description = "value to set the nat gateway id"
  type        = string
  default     = null
}
