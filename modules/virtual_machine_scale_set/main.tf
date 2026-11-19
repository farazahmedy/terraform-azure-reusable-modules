resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  instances           = var.instances
  admin_username      = var.admin_username
  upgrade_mode        = "Automatic"
  tags                = var.tags

  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.ssh.public_key_openssh
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Premium_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name                          = "nic-vmss"
    primary                       = true
    enable_accelerated_networking = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_id
    }
  }

  identity {
    type = "SystemAssigned"
  }
}
