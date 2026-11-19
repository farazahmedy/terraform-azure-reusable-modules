# Example: Complete Production VM Environment using Reusable Modules
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.90.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# 1. Resource Group
resource "azurerm_resource_group" "main" {
  name     = "rg-vm-workload-prod"
  location = "eastus"
}

# 2. Reusable Virtual Network & Subnets Module
module "network" {
  source              = "../../modules/virtual_network"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  vnet_name           = "vnet-vm-prod"
  address_space       = ["10.10.0.0/16"]

  subnets = {
    "AzureBastionSubnet" = { address_prefixes = ["10.10.0.0/24"] }
    "snet-workload-vms"  = { address_prefixes = ["10.10.1.0/24"] }
  }
}

# 3. Reusable Azure Bastion Host Module (No Public IP on VMs required!)
module "bastion" {
  source              = "../../modules/bastion_host"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  name                = "bastion-prod"
  subnet_id           = module.network.subnet_ids["AzureBastionSubnet"]
}

# 4. Reusable Linux Virtual Machine Module
module "linux_app_vm" {
  source               = "../../modules/linux_virtual_machine"
  resource_group_name  = azurerm_resource_group.main.name
  location             = azurerm_resource_group.main.location
  vm_name              = "vm-linux-app01"
  subnet_id            = module.network.subnet_ids["snet-workload-vms"]
  vm_size              = "Standard_D2s_v5"
  admin_username       = "azureuser"
  enable_auto_shutdown = true
  shutdown_time        = "1900" # 7:00 PM UTC auto shutdown

  tags = {
    Environment = "production"
    Owner       = "Faraz Ahmed"
    Role        = "Backend Web App"
  }
}

# 5. Reusable Windows Virtual Machine Module
module "windows_db_vm" {
  source               = "../../modules/windows_virtual_machine"
  resource_group_name  = azurerm_resource_group.main.name
  location             = azurerm_resource_group.main.location
  vm_name              = "vm-win-sql01"
  subnet_id            = module.network.subnet_ids["snet-workload-vms"]
  vm_size              = "Standard_D4s_v5"
  admin_username       = "azureadmin"
  enable_auto_shutdown = true

  tags = {
    Environment = "production"
    Owner       = "Faraz Ahmed"
    Role        = "Windows SQL Server"
  }
}

# Outputs
output "linux_vm_private_ip" {
  value = module.linux_app_vm.private_ip_address
}

output "windows_vm_private_ip" {
  value = module.windows_db_vm.private_ip_address
}

output "bastion_fqdn" {
  value = module.bastion.bastion_fqdn
}
