resource "azurerm_resource_group" "rg" {
  name     = "${var.project_name}-rg"
  location = var.location
}

# Sufijo aleatorio para el DNS del contenedor
resource "random_string" "dns" {
  length  = 6
  special = false
  upper   = false
}

# ============== AZURE CONTAINER INSTANCE ==============

resource "azurerm_container_group" "app" {
  name                = "${var.project_name}-aci"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_address_type = "Public"
  os_type         = "Linux"

  # DNS label: http://<dns>.region.azurecontainer.io
  dns_name_label = "${var.project_name}-${random_string.dns.result}"

  container {
    name   = "web"
    image  = var.docker_image
    cpu    = "1"
    memory = "1.5"

    ports {
      port     = 8080
      protocol = "TCP"
    }
  }

  tags = {
    project = var.project_name
  }
}

# ============== AZURE DATABASE FOR MYSQL FLEXIBLE SERVER ==============
resource "azurerm_mysql_flexible_server" "db" {
  name                = "${var.project_name}-mysql"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  administrator_login    = var.mysql_admin
  administrator_password = var.mysql_password

  sku_name = "B_Standard_B1ms"
  version  = "8.0.21"

  storage {
    size_gb = 20
  }

  backup_retention_days = 7

  tags = {
    project = var.project_name
  }
}


resource "azurerm_mysql_flexible_database" "db" {
  depends_on = [azurerm_mysql_flexible_server.db]

  name                = "carrosdb"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.db.name
  charset             = "utf8"
  collation           = "utf8_general_ci"
}

# Regla de firewall para permitir todas las IPs (solo DEMO, no en producción)
resource "azurerm_mysql_flexible_server_firewall_rule" "allow_all" {
  depends_on = [azurerm_mysql_flexible_server.db]

  name                = "allow-all"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.db.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}
