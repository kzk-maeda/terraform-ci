variable "cidr_blocks" {
  type = "map"
  default = {
    global     = "0.0.0.0/0"
    client_vpn = "10.255.0.0/16"
  }
}
