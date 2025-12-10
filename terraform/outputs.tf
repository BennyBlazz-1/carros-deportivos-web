output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "app_url" {
  description = "URL pública de la app de carros deportivos"
  value       = "http://${azurerm_container_group.app.fqdn}:8080"
}

output "mysql_host" {
  description = "Host de la base de datos MySQL"
  value       = azurerm_mysql_flexible_server.db.fqdn
}

output "mysql_admin_user" {
  value = "${var.mysql_admin}@${azurerm_mysql_flexible_server.db.name}"
}
