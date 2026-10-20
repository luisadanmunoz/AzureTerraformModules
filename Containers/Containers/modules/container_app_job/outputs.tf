#############################################################################
# OUTPUT CONTAINER APP JOB
#############################################################################
output "id" {
  value = azurerm_container_app_job.container_app_job.id
}

output "name" {
  value = azurerm_container_app_job.container_app_job.name
}

output "event_stream_endpoint" {
  value = azurerm_container_app_job.container_app_job.event_stream_endpoint
}
