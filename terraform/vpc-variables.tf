
variable "vpc_name" {}
variable "cidr" {}
variable "public_subnets" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}

variable "is_nat_gateway_enabled" {
  default = true
  type = bool
}

variable "is_single_nat_gateway" {
  default = false
  type = bool
}

variable "are_dns_hostnames_enabled" {
  default = true
  type = bool
}

variable "availability_zones" {
  type = list(string)
}