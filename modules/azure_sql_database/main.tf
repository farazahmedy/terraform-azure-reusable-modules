resource "random_password" "admin" {
  length           = 24
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_mssql_server" "sql" {
  name                         = var.server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "sqladminuser"
  administrator_login_password = random_password.admin.result
  minimum_tls_version          = "1.2"
  public_network_access_enabled = !var.enable_private_endpoint
  tags                         = var.tags
}

resource "azurerm_mssql_database" "db" {
  name         = var.database_name
  server_id    = azurerm_mssql_server.sql.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  sku_name     = var.sku_name
  tags         = var.tags
}

resource "azurerm_private_endpoint" "sql" {
  count               = var.enable_private_endpoint ? 1 : 0
  name                = "pe-${var.server_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "psc-${var.server_name}"
    private_connection_resource_id = azurerm_mssql_server.sql.id
    is_manual_connection           = false
    subresource_names              = ["sqlServer"]
  }
}
