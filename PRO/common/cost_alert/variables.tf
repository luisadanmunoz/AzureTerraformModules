#############################################################################
# COST ANOMALY ALERT
#############################################################################
variable "name" {
  description = "value of the name tag"
  type        = string
}
variable "display_name" {
  description = "value of the display name tag"
  type        = string
}
variable "subscription_id" {
  description = "value of the subscription id tag"
  type        = string
}
variable "email_subject" {
  description = "value of the email subject tag"
  type        = string
}
variable "email_addresses" {
  description = "value of the email addresses tag"
  type        = set(string)
}