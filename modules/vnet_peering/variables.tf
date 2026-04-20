variable "peering_name" {
  description = "The name of the virtual network peering."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "remote_virtual_network_id" {
  description = "The ID of the remote virtual network."
  type        = string
}

variable "allow_forwarded_traffic" {
  description = "Whether to allow forwarded traffic."
  type        = bool
  default     = false
}

variable "allow_gateway_transit" {
  description = "Whether to allow gateway transit."
  type        = bool
  default     = false
}