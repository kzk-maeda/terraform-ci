resource "aws_ec2_client_vpn_endpoint" "this" {
  description            = "kzk client vpn endpoint test"
  server_certificate_arn = data.aws_acm_certificate.server_certificate.arn
  client_cidr_block      = var.vpn_client_cidr_blocks
  dns_servers            = ["10.0.0.2", "8.8.8.8"]
  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = data.aws_acm_certificate.client_certificate.arn
  }
  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.vpn.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.vpn.name
  }
  tags = {
    Name = "vpn_endpoint"
  }
}

# security group
resource "aws_security_group" "this" {
  name        = "vpn"
  description = "VPN"
  vpc_id      = aws_vpc.vpn_client.id

  ingress {
    description = "any"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.vpn_client.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "vpn"
  }
}

# Association
resource "aws_ec2_client_vpn_network_association" "private" {
  for_each = aws_subnet.private

  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  subnet_id              = each.value.id
  security_groups        = [aws_security_group.this.id]
}

# Authorize
resource "aws_ec2_client_vpn_authorization_rule" "vpc" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  target_network_cidr    = aws_vpc.vpn_client.cidr_block
  authorize_all_groups   = true
}

resource "aws_ec2_client_vpn_authorization_rule" "Internet" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  target_network_cidr    = "0.0.0.0/0"
  authorize_all_groups   = true
}

# Route Table to allow Internet access
resource "aws_ec2_client_vpn_route" "private" {
  for_each = aws_ec2_client_vpn_network_association.private

  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  destination_cidr_block = "0.0.0.0/0"
  target_vpc_subnet_id   = each.value.subnet_id
}
