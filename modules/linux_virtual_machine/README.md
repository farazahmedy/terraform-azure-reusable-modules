# 🐧 Reusable Linux Virtual Machine Module

Production-grade, reusable Terraform module for deploying Azure Linux Virtual Machines (Ubuntu/Debian/RHEL) with Managed Identity, SSH key authentication, Accelerated Networking, and auto-shutdown cost optimization.

---

## 🚀 Usage Example

```hcl
module "app_server" {
  source              = "git::https://github.com/farazahmedy/terraform-azure-reusable-modules.git//modules/linux_virtual_machine"
  resource_group_name = "rg-production-eastus"
  location            = "eastus"
  vm_name             = "vm-app-prod-01"
  subnet_id           = module.network.app_subnet_id
  vm_size             = "Standard_D2s_v5"
  admin_username      = "azureuser"
  os_disk_type        = "Premium_LRS"
  os_disk_size_gb     = 128
  enable_auto_shutdown = true
  shutdown_time       = "2000" # 8:00 PM UTC

  tags = {
    Environment = "production"
    Owner       = "Faraz Ahmed"
    Role        = "Application Server"
  }
}
```
