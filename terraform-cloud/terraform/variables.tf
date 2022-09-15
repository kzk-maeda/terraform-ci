variable "vpn_client_cidr_blocks" {
  default = "1.0.0.0/16"
}

variable "env" {
}

variable "vpc_cidr_block" {
}

variable "public_subnet_cidr_blocks" {
  # type = "map"
}

variable "private_subnet_cidr_blocks" {
  # type = "map"
}
