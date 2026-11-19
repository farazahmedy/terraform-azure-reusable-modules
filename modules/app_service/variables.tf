variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "name" { type = string }
variable "sku_name" { type = string; default = "B1" }
variable "node_version" { type = string; default = "18-lts" }
variable "subnet_id" { type = string; default = null; description = "Subnet ID for regional VNet integration" }
variable "app_settings" { type = map(string); default = {} }
variable "tags" { type = map(string); default = {} }
