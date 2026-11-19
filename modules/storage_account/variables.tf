variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "name" { type = string }
variable "account_tier" { type = string; default = "Standard" }
variable "replication_type" { type = string; default = "GRS" }
variable "containers" { type = list(string); default = [] }
variable "enable_private_endpoint" { type = bool; default = false }
variable "private_endpoint_subnet_id" { type = string; default = null }
variable "tags" { type = map(string); default = {} }
