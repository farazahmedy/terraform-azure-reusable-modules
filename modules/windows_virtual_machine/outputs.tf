output "vm_id" {
  value = azurerm_windows_virtual_machine.vm.id
}

output "vm_name" {
  value = azurerm_windows_virtual_machine.vm.name
}

output "private_ip_address" {
  value = azurerm_network_interface.nic.private_ip_address
}

output "public_ip_address" {
  value = var.enable_public_ip ? azurerm_public_ip.pip[0].ip_address : null
}

output "admin_password" {
  value     = var.admin_password != "" ? var.admin_password : random_password.password[0].result
  sensitive = true
}
