variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "name" { type = string; default = "natgw-core" }
variable "subnet_ids" { type = list(string); default = [] }
variable "tags" { type = map(string); default = {} }
