variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
}

variable "location" {
  description = "Azure region where the Virtual Network will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group where the Virtual Network will be created"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to the Virtual Network"
  type        = map(string)
  default     = {}
}

variable "subnets" {
  description = "A map of subnet names to address prefixes"
  type = set(object({
    name             = string
    address_prefixes = list(string)
  }))
}