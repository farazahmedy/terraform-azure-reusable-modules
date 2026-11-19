resource "azurerm_service_plan" "plan" {
  name                = "asp-${var.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.sku_name
  tags                = var.tags
}

resource "azurerm_linux_web_app" "app" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.plan.id
  https_only          = true
  app_settings        = var.app_settings
  tags                = var.tags

  site_config {
    always_on = var.sku_name != "F1" && var.sku_name != "D1"
    application_stack {
      node_version = var.node_version
    }
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "vnet" {
  count          = var.subnet_id != null ? 1 : 0
  app_service_id = azurerm_linux_web_app.app.id
  subnet_id      = var.subnet_id
}
