variable "vnet_name" {
  description = "vnet_name"
  type        = string
}

variable "location" {
  description = "location"
  type        = string
}

variable "resource_group_name" {
  description = "resource_group_name"
  type        = string
}

variable "web_cidr" {
  description = "web_cidr"
  default = "10.0.1.0/24"
  type        = string
}

variable "db_cidr" {
  description = "db_cidr"
  default = "10.0.2.0/24"
  type        = string
}

