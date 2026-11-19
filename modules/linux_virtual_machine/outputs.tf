output "vm_id" {
  description = "The Resource ID of the Linux Virtual Machine"
  value       = azurerm_linux_virtual_machine.vm.id
}

output "vm_name" {
  description = "The name of the Linux Virtual Machine"
  value       = azurerm_linux_virtual_machine.vm.name
}

output "nic_id" {
  description = "The Resource ID of the Network Interface"
  value       = azurerm_network_interface.vm.id
}

output "private_ip_address" {
  description = "The private IP address allocated to the VM NIC"
  value       = azurerm_network_interface.vm.private_ip_address
}

output "public_ip_address" {
  description = "The public IP address attached to the VM (if enabled)"
  value       = var.enable_public_ip ? azurerm_public_ip.vm[0].ip_address : null
}

output "principal_id" {
  description = "The System-Assigned Managed Identity Principal ID"
  value       = azurerm_linux_virtual_machine.vm.identity[0].principal_id
}

output "ssh_private_key_pem" {
  description = "Generated SSH Private Key in PEM format (sensitive)"
  value       = var.ssh_public_key == "" ? tls_private_key.ssh[0].private_key_pem : null
  sensitive   = true
}
