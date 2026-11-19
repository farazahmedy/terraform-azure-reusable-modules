# 🧱 Terraform Azure Enterprise Reusable Modules Library

[![Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Microsoft Azure](https://img.shields.io/badge/Microsoft_Azure-0078D4?style=for-the-badge&logo=microsoft-azure&logoColor=white)](https://azure.microsoft.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

A battle-tested, production-ready library of **modular, reusable Terraform code for Microsoft Azure**. Designed for cloud architects, platform engineers, and DevOps practitioners to spin up compliant infrastructure in minutes by simply calling modules.

---

## 📑 Reusable Modules Catalog

| Module | Category | Description | Source Path |
| :--- | :--- | :--- | :--- |
| 🐧 [**`linux_virtual_machine`**](./modules/linux_virtual_machine) | **Compute** | Ubuntu / RHEL VM with Managed Identity, SSH keys, Accelerated Networking, OS disk encryption, and auto-shutdown. | `//modules/linux_virtual_machine` |
| 🪟 [**`windows_virtual_machine`**](./modules/windows_virtual_machine) | **Compute** | Windows Server 2022/2019 VM with random password, Accelerated Networking, and auto-shutdown. | `//modules/windows_virtual_machine` |
| 🔄 [**`virtual_machine_scale_set`**](./modules/virtual_machine_scale_set) | **Compute** | Linux VMSS with horizontal autoscaling based on CPU metrics and Load Balancer integration. | `//modules/virtual_machine_scale_set` |
| 🛡️ [**`bastion_host`**](./modules/bastion_host) | **Networking** | Azure Bastion Host + dedicated Public IP for secure browser RDP/SSH without exposing VMs to internet. | `//modules/bastion_host` |
| 🌐 [**`nat_gateway`**](./modules/nat_gateway) | **Networking** | High-availability NAT Gateway with static egress public IP for private subnets. | `//modules/nat_gateway` |
| 🗺️ [**`virtual_network`**](./modules/virtual_network) | **Networking** | Dynamic VNet with subnets, service endpoints, and subnet delegations (App Service, AKS, Container Apps). | `//modules/virtual_network` |
| 🔒 [**`network_security_group`**](./modules/network_security_group) | **Networking** | Dynamic 5-tuple NSG rules with automated subnet associations. | `//modules/network_security_group` |
| 📦 [**`storage_account`**](./modules/storage_account) | **Storage** | Secure Storage Account with TLS 1.2, Private Endpoint, blob versioning, and retention. | `//modules/storage_account` |
| 🗝️ [**`key_vault`**](./modules/key_vault) | **Security** | Azure Key Vault with RBAC authorization, purge protection enabled, and network ACLs. | `//modules/key_vault` |
| ☸️ [**`aks_cluster`**](./modules/aks_cluster) | **Containers** | Managed Kubernetes (AKS) cluster with Azure CNI, managed identity, and auto-scaling node pools. | `//modules/aks_cluster` |
| 🗄️ [**`azure_sql_database`**](./modules/azure_sql_database) | **Database** | Azure SQL Server & DB with Serverless autoscaling and Private Endpoint connection. | `//modules/azure_sql_database` |
| 🚀 [**`app_service`**](./modules/app_service) | **PaaS** | Linux App Service Plan & Web App with regional VNet Integration and HTTPS enforcement. | `//modules/app_service` |

---

## 💻 How to Call These Modules in Your Code

### 1. Call Linux Virtual Machine Module
```hcl
module "my_linux_vm" {
  source              = "git::https://github.com/farazahmedy/terraform-azure-reusable-modules.git//modules/linux_virtual_machine"
  resource_group_name = "rg-prod-eastus"
  location            = "eastus"
  vm_name             = "vm-prod-app01"
  subnet_id           = module.network.subnet_ids["snet-workload-vms"]
  vm_size             = "Standard_D2s_v5"
  admin_username      = "azureuser"
  enable_auto_shutdown = true
  shutdown_time       = "1900" # 7:00 PM UTC daily

  tags = {
    Environment = "production"
    Owner       = "Faraz Ahmed"
  }
}
```

### 2. Call Windows Virtual Machine Module
```hcl
module "my_windows_vm" {
  source              = "git::https://github.com/farazahmedy/terraform-azure-reusable-modules.git//modules/windows_virtual_machine"
  resource_group_name = "rg-prod-eastus"
  location            = "eastus"
  vm_name             = "vm-win-sql01"
  subnet_id           = module.network.subnet_ids["snet-workload-vms"]
  vm_size             = "Standard_D4s_v5"
  admin_username      = "azureadmin"
  enable_auto_shutdown = true
}
```

### 3. Call Azure Bastion Host Module
```hcl
module "my_bastion" {
  source              = "git::https://github.com/farazahmedy/terraform-azure-reusable-modules.git//modules/bastion_host"
  resource_group_name = "rg-hub-network"
  location            = "eastus"
  name                = "bastion-hub"
  subnet_id           = module.network.subnet_ids["AzureBastionSubnet"]
}
```

### 4. Call Secure Storage Account with Private Endpoint
```hcl
module "secure_storage" {
  source                     = "git::https://github.com/farazahmedy/terraform-azure-reusable-modules.git//modules/storage_account"
  resource_group_name        = "rg-prod-eastus"
  location                   = "eastus"
  name                       = "stcloudprodeastus001"
  containers                 = ["raw-data", "backups", "tfstate"]
  enable_private_endpoint    = true
  private_endpoint_subnet_id = module.network.subnet_ids["snet-private-endpoints"]
}
```

---

## 🌟 Full Working End-to-End Example

Check out the [**`examples/complete_vm_environment/main.tf`**](./examples/complete_vm_environment/main.tf) file to see how all modules (VNet, Bastion, Linux VM, Windows VM) are called together in a single architecture!

---

## 👤 Author

Developed by **Faraz Ahmed** ([@farazahmedy](https://github.com/farazahmedy)).
Feel free to fork, contribute new modules, or open an issue!
