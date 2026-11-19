variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "cluster_name" { type = string }
variable "dns_prefix" { type = string; default = "aks" }
variable "subnet_id" { type = string }
variable "vm_size" { type = string; default = "Standard_D2s_v5" }
variable "node_count" { type = number; default = 2 }
variable "tags" { type = map(string); default = {} }
