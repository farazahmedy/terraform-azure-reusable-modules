# Generate SSH key if not provided
resource "tls_private_key" "ssh" {
  count     = var.ssh_public_key == "" ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Optional Public IP
resource "azurerm_public_ip" "vm" {
  count               = var.enable_public_ip ? 1 : 0
  name                = "pip-${var.vm_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

# Network Interface Card (NIC)
resource "azurerm_network_interface" "vm" {
  name                          = "nic-${var.vm_name}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  enable_accelerated_networking = true
  tags                          = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.enable_public_ip ? azurerm_public_ip.vm[0].id : null
  }
}

# Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.vm_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.vm_size
  admin_username                  = var.admin_username
  network_interface_ids           = [azurerm_network_interface.vm.id]
  disable_password_authentication = true
  tags                            = var.tags

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key != "" ? var.ssh_public_key : tls_private_key.ssh[0].public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
    disk_size_gb         = var.os_disk_size_gb
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  identity {
    type = "SystemAssigned"
  }
}

# Auto-Shutdown Schedule (FinOps Cost Optimization)
resource "azurerm_dev_test_global_vm_shutdown_schedule" "shutdown" {
  count              = var.enable_auto_shutdown ? 1 : 0
  virtual_machine_id = azurerm_linux_virtual_machine.vm.id
  location           = var.location
  enabled            = true

  daily_recurrence_time = var.shutdown_time
  timezone              = var.timezone

  notification_settings {
    enabled = false
  }
}
