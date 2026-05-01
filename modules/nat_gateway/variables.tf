variable "nat_gateway_name" {
  description = "The name of the NAT gateway"
  type        = string
}

variable "location" {
  description = "The location of the NAT gateway"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "sku_name" {
  description = "The SKU name of the NAT gateway"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs to associate with the NAT gateway"
  type        = list(string)
}