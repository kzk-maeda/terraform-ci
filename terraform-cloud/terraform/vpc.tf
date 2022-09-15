### VPC
resource "aws_vpc" "vpn_client" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpn_client_vpc"
  }
}

### Subnet
resource "aws_subnet" "public" {
  for_each = var.public_subnet_cidr_blocks

  vpc_id            = aws_vpc.vpn_client.id
  availability_zone = each.key
  cidr_block        = each.value.cidr_block

  tags = {
    Name = "vpn_client_public_${each.value.name}"
  }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnet_cidr_blocks

  vpc_id            = aws_vpc.vpn_client.id
  availability_zone = each.key
  cidr_block        = each.value.cidr_block

  tags = {
    Name = "vpn_client_private_${each.value.name}"
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
resource "aws_eip" "nat" {
  for_each = var.public_subnet_cidr_blocks

  vpc = true

  tags = {
    Name = "vpn_client-natgw-${each.value.name}"
  }
}

resource "aws_nat_gateway" "nat" {
  for_each = var.public_subnet_cidr_blocks

  subnet_id     = aws_subnet.private[each.key].id
  allocation_id = aws_eip.nat[each.key].id

  tags = {
    Name = "vpn_client-${each.value.name}"
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

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

#### Private
resource "aws_route_table" "private" {
  for_each = var.private_subnet_cidr_blocks

  vpc_id = aws_vpc.vpn_client.id

  tags = {
    Name = "vpn_client-private-${each.value.name}"
  }
}

resource "aws_route" "private" {
  for_each = var.private_subnet_cidr_blocks

  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.private[each.key].id
  nat_gateway_id         = aws_nat_gateway.nat[each.key].id
}

resource "aws_route_table_association" "private_1a" {
  for_each = var.private_subnet_cidr_blocks

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}
