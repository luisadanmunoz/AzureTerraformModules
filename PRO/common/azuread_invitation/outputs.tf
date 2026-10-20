output "id" {
  description = "value of the azuread invitation id"
  value       = azuread_group_member.member.group_object_id
}
