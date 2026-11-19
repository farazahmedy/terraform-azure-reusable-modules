resource "random_password" "password" {
  count            = var.admin_password == "" ? 1 : 0
  length           = 20
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_public_ip" "pip" {
  count               = var.enable_public_ip ? 1 : 0
  name                = "pip-${var.vm_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_network_interface" "nic" {
  name                          = "nic-${var.vm_name}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  enable_accelerated_networking = true
  tags                          = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.enable_public_ip ? azurerm_public_ip.pip[0].id : null
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                  = var.vm_name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password != "" ? var.admin_password : random_password.password[0].result
  network_interface_ids = [azurerm_network_interface.nic.id]
  tags                  = var.tags

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
    disk_size_gb         = var.os_disk_size_gb
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.windows_sku
    version   = "latest"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "shutdown" {
  count              = var.enable_auto_shutdown ? 1 : 0
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id
  location           = var.location
  enabled            = true

  daily_recurrence_time = var.shutdown_time
  timezone              = var.timezone

  notification_settings {
    enabled = false
  }
}
