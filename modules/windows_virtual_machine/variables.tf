variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "vm_name" { type = string }
variable "subnet_id" { type = string }
variable "vm_size" { type = string; default = "Standard_D2s_v5" }
variable "admin_username" { type = string; default = "azureadmin" }
variable "admin_password" { type = string; default = "" }
variable "enable_public_ip" { type = bool; default = false }
variable "os_disk_type" { type = string; default = "Premium_LRS" }
variable "os_disk_size_gb" { type = number; default = 128 }
variable "windows_sku" { type = string; default = "2022-datacenter-azure-edition" }
variable "enable_auto_shutdown" { type = bool; default = true }
variable "shutdown_time" { type = string; default = "1900" }
variable "timezone" { type = string; default = "UTC" }
variable "tags" { type = map(string); default = {} }
