#############################################################################
# PRIVATE DNS A RECORD VARIABLES
#############################################################################
variable "name" {
  type = string
}
variable "zone_name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "ttl" {
  type = number
}
variable "records" {
  type = set(string)
}