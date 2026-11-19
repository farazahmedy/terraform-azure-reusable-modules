variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "name" { type = string }
variable "sku_name" { type = string; default = "standard" }
variable "allowed_subnet_ids" { type = list(string); default = [] }
variable "tags" { type = map(string); default = {} }
