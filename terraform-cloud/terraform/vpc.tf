### VPC
resource "aws_vpc" "vpn_client" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpn_client_vpc"
  }
}

### Subnet
resource "aws_subnet" "public_1a" {
  vpc_id = aws_vpc.vpn_client.id

  availability_zone = "ap-northeast-1a"

  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "vpn_client_public_1a"
  }
}

resource "aws_subnet" "public_1c" {
  vpc_id = aws_vpc.vpn_client.id

  availability_zone = "ap-northeast-1c"

  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "vpn_client_public_1c"
  }
}

resource "aws_subnet" "private_1a" {
  vpc_id = aws_vpc.vpn_client.id

  availability_zone = "ap-northeast-1a"

  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "vpn_client_private_1a"
  }
}

resource "aws_subnet" "private_1c" {
  vpc_id = aws_vpc.vpn_client.id

  availability_zone = "ap-northeast-1c"

  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "vpn_client_private_1c"
  }
}

### IGW
resource "aws_internet_gateway" "vpn_client" {
  vpc_id = aws_vpc.vpn_client.id

  tags = {
    Name = "vpn_client"
  }
}

### NGW
resource "aws_eip" "nat_1a" {
  vpc = true

  tags = {
    Name = "vpn_client-natgw-1a"
  }
}

resource "aws_nat_gateway" "nat_1a" {
  subnet_id     = aws_subnet.public_1c.id
  allocation_id = aws_eip.nat_1a.id

  tags = {
    Name = "vpn_client-1a"
  }
}

resource "aws_eip" "nat_1c" {
  vpc = true

  tags = {
    Name = "vpn_client-natgw-1c"
  }
}

resource "aws_nat_gateway" "nat_1c" {
  subnet_id     = aws_subnet.public_1c.id
  allocation_id = aws_eip.nat_1c.id

  tags = {
    Name = "vpn_client-1c"
  }
}

### Route Table
#### Public
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpn_client.id

  tags = {
    Name = "vpn_client-public"
  }
}

resource "aws_route" "public" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.vpn_client.id
}

resource "aws_route_table_association" "public_1a" {
  subnet_id      = aws_subnet.public_1a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_1c" {
  subnet_id      = aws_subnet.public_1c.id
  route_table_id = aws_route_table.public.id
}

#### Private
resource "aws_route_table" "private_1a" {
  vpc_id = aws_vpc.vpn_client.id

  tags = {
    Name = "vpn_client-private-1a"
  }
}

resource "aws_route_table" "private_1c" {
  vpc_id = aws_vpc.vpn_client.id

  tags = {
    Name = "vpn_client-private-1c"
  }
}

resource "aws_route" "private_1a" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.private_1a.id
  nat_gateway_id         = aws_nat_gateway.nat_1a.id
}

resource "aws_route" "private_1c" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.private_1c.id
  nat_gateway_id         = aws_nat_gateway.nat_1c.id
}

resource "aws_route_table_association" "private_1a" {
  subnet_id      = aws_subnet.private_1a.id
  route_table_id = aws_route_table.private_1a.id
}

resource "aws_route_table_association" "private_1c" {
  subnet_id      = aws_subnet.private_1c.id
  route_table_id = aws_route_table.private_1c.id
}
