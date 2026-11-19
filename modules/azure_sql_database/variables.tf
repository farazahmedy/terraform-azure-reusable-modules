variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "server_name" { type = string }
variable "database_name" { type = string }
variable "sku_name" { type = string; default = "GP_S_Gen5_1" }
variable "enable_private_endpoint" { type = bool; default = false }
variable "private_endpoint_subnet_id" { type = string; default = null }
variable "tags" { type = map(string); default = {} }
