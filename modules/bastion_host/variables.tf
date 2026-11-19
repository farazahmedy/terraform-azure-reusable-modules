variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "name" { type = string; default = "bastion-hub" }
variable "subnet_id" { type = string; description = "Resource ID of the AzureBastionSubnet" }
variable "sku" { type = string; default = "Standard" }
variable "tags" { type = map(string); default = {} }
