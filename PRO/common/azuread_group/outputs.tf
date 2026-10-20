output "id" {
  description = "value of the azuread group id"
  value       = azuread_group.group.id
}
output "display_name" {
  description = "value of the azuread group display name"
  value       = azuread_group.group.display_name
}
