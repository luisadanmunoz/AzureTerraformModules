#############################################################################
# ROUTE TABLE VARIABLES
#############################################################################
variable "name" {
  type = string
}
variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}
#############################################################################
# DYNAMIC BLOCKS ROUTE VARIABLES
#############################################################################
variable "routes" {
  description = "Lista de rutas para la tabla de enrutamiento"
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = string
  }))
  default = []
}

variable "enable_route" {
  description = "Habilitar rutas en la tabla de enrutamiento"
  type        = bool
}
