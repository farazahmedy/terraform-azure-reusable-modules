variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "name" { type = string }
variable "subnet_id" { type = string }
variable "sku" { type = string; default = "Standard_B2s" }
variable "instances" { type = number; default = 2 }
variable "admin_username" { type = string; default = "azureuser" }
variable "tags" { type = map(string); default = {} }
