# #############################################################################
# # STORAGE ACCOUNT - VARIABLES
# #############################################################################
variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}
# #############################################################################
# # STORAGE ACCOUNT - CONTAINER
# #############################################################################
variable "container" {
  type = string
}
variable "tags" {
  type    = map(any)
  default = {}
}
# #############################################################################
# # STORAGE ACCOUNT - PRIVATE ENDPOINT
# #############################################################################
variable "subnet_id" {
  default = {}
}
