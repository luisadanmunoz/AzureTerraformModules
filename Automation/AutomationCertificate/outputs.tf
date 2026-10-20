################################################################################
# Certificate Outputs
################################################################################

output "certificate_ids" {
  description = "Map of certificate names to their IDs."
  value = {
    for name, cert in azurerm_automation_certificate.this :
    name => cert.id
  }
}

output "certificate_names" {
  description = "List of created certificate names."
  value       = keys(azurerm_automation_certificate.this)
}

output "certificate_thumbprints" {
  description = "Map of certificate names to their thumbprints."
  value = {
    for name, cert in azurerm_automation_certificate.this :
    name => cert.thumbprint
  }
}

output "certificate_expiry_dates" {
  description = "Map of certificate names to their expiry dates."
  value = {
    for name, cert in azurerm_automation_certificate.this :
    name => cert.expiry_time
  }
}
