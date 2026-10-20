#############################################################################
# IOTHUB - VARIABLES
#############################################################################

variable "name" {
  default = {}
}
variable "resource_group_name" {
  default = {}
}
variable "location" {
  default = {}
}
variable "sta_id" {
  default = {}
}
variable "connection_string_diag" {
  default = {}
}
variable "tags" {
  type    = map(any)
  default = {}
}

#############################################################################
# PRIVATE ENDPOINT - VARIABLES
#############################################################################

variable "subnet_id" {
  default = {}
}
variable "private_dns_zone_ids" {
  default = {}
}

variable "connection_string_sta" {
  default = {}
}

variable "container_name" {
  default = {}
}
variable "connection_string" {
  default = {}
}