# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
module "vpc2" {
  source = "terraform-aws-modules/vpc/aws"
  name = "vpn_client_vpc2"
  cidr = "10.0.0.0/16"

  enable_dns_hostnames = true
  enable_dns_support   = true

  azs            = ["ap-northeast-1a", "ap-northeast-1c"]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
  
  enable_nat_gateway  = true
  single_nat_gateway  = false
  one_nat_gateway_per_az = true

  reuse_nat_ips       = true
  external_nat_ip_ids = aws_eip.nat.*.id
}

resource "aws_eip" "nat" {
  count = 2

  vpc = true
}
