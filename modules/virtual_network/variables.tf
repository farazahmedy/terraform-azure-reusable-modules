variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "vnet_name" { type = string }
variable "address_space" { type = list(string) }
variable "subnets" {
  type = map(object({
    address_prefixes  = list(string)
    service_endpoints = optional(list(string), [])
    delegation_name   = optional(string, null)
    service_name      = optional(string, null)
    service_actions   = optional(list(string), [])
  }))
  default = {}
}
variable "tags" { type = map(string); default = {} }
