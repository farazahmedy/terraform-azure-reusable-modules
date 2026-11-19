variable "resource_group_name" {
  type        = string
  description = "Name of the parent resource group"
}

variable "location" {
  type        = string
  description = "Azure region where the VM will be deployed"
}

variable "vm_name" {
  type        = string
  description = "Name of the Linux Virtual Machine"
}

variable "subnet_id" {
  type        = string
  description = "Resource ID of the subnet where the VM NIC will be attached"
}

variable "vm_size" {
  type        = string
  description = "Virtual Machine size / SKU (e.g., Standard_B2s, Standard_D2s_v5)"
  default     = "Standard_B2s"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the Linux VM"
  default     = "azureuser"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH Public Key string for authentication (if empty, one will be generated)"
  default     = ""
}

variable "enable_public_ip" {
  type        = bool
  description = "Whether to attach a Public IP to the VM NIC"
  default     = false
}

variable "os_disk_type" {
  type        = string
  description = "Storage account type for OS Disk (Standard_LRS, StandardSSD_LRS, Premium_LRS)"
  default     = "Premium_LRS"
}

variable "os_disk_size_gb" {
  type        = number
  description = "Size of the OS disk in GB"
  default     = 64
}

variable "image_publisher" {
  type        = string
  description = "OS Image publisher"
  default     = "Canonical"
}

variable "image_offer" {
  type        = string
  description = "OS Image offer"
  default     = "0001-com-ubuntu-server-jammy"
}

variable "image_sku" {
  type        = string
  description = "OS Image SKU"
  default     = "22_04-lts-gen2"
}

variable "image_version" {
  type        = string
  description = "OS Image version"
  default     = "latest"
}

variable "enable_auto_shutdown" {
  type        = bool
  description = "Whether to enable scheduled auto-shutdown to save cloud costs"
  default     = true
}

variable "shutdown_time" {
  type        = string
  description = "Daily shutdown time in 24h format (e.g. 1900 for 7:00 PM)"
  default     = "1900"
}

variable "timezone" {
  type        = string
  description = "Timezone for auto shutdown schedule"
  default     = "UTC"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all provisioned resources"
  default     = {}
}
