env            = "dev"
vpc_cidr_block = "10.0.0.0/16"
public_subnet_cidr_blocks = {
  ap-northeast-1a = {
    cidr_block = "10.0.1.0/24"
    name       = "1a"
  }
  ap-northeast-1c = {
    cidr_block = "10.0.2.0/24"
    name       = "1c"
  }
}
private_subnet_cidr_blocks = {
  ap-northeast-1a = {
    cidr_block = "10.0.3.0/24"
    name       = "1a"
  }
  ap-northeast-1c = {
    cidr_block = "10.0.4.0/24"
    name       = "1c"
  }
}
