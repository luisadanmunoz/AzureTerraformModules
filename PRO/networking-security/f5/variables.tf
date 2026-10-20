#############################################################################
# LINUX VIRTUAL MACHINE - F5 BIGIP - VARIABLES
#############################################################################
variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "size" {
  type = string
}
variable "subnet_mgmt_id" {
  type = string
}
variable "subnet_private_id" {
  type = string
}
variable "subnet_public_id" {
  type = string
}
variable "subnet_public_id_2" {
  type = string
}
variable "zone" {
  type = string
}
variable "ip_public" {
  type = string
}
variable "ip_public_2" {
  type = string
}
variable "ip_private" {
  type = string
}
variable "ip_management" {
  type = string
}
/*
variable "keyvault_id" {
  default = {}
}

variable "public_ip_address_id" {
  type = string
}
*/
variable "INIT_URL" {
  description = "URL to download the BIG-IP runtime init"
  type        = string
  default     = "https://cdn.f5.com/product/cloudsolutions/f5-bigip-runtime-init/v2.0.2/dist/f5-bigip-runtime-init-2.0.2-1.gz.run"
}

variable "DO_URL" {
  description = "URL to download the BIG-IP Declarative Onboarding module"
  type        = string
  default     = "https://github.com/F5Networks/f5-declarative-onboarding/releases/download/v1.44.0/f5-declarative-onboarding-1.44.0-5.noarch.rpm"
}

variable "AS3_URL" {
  description = "URL to download the BIG-IP Application Service Extension 3 (AS3) module"
  type        = string
  default     = "https://github.com/F5Networks/f5-appsvcs-extension/releases/download/v3.51.0/f5-appsvcs-3.51.0-5.noarch.rpm"
}

variable "TS_URL" {
  description = "URL to download the BIG-IP Telemetry Streaming module"
  type        = string
  default     = "https://github.com/F5Networks/f5-telemetry-streaming/releases/download/v1.35.0/f5-telemetry-1.35.0-1.noarch.rpm"
}

variable "CFE_URL" {
  description = "URL to download the BIG-IP Cloud Failover Extension module"
  type        = string
  default     = "https://github.com/F5Networks/f5-cloud-failover-extension/releases/download/v2.1.1/f5-cloud-failover-2.1.1-1.noarch.rpm"
}

variable "FAST_URL" {
  description = "URL to download the BIG-IP FAST module"
  type        = string
  default     = "https://github.com/F5Networks/f5-appsvcs-templates/releases/download/v1.25.0/f5-appsvcs-templates-1.25.0-1.noarch.rpm"
}


