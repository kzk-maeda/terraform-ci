resource "aws_ec2_client_vpn_endpoint" "this" {
  description            = "kzk client vpn endpoint test"
  server_certificate_arn = data.aws_acm_certificate.server_certificate.arn
  client_cidr_block      = var.vpn_client_cidr_blocks
  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = data.aws_acm_certificate.client_certificate.arn
  }
  connection_log_options {
    enabled = false
  }
  tags = {
    Name = "vpn_endpoint"
  }
}

# Association
resource "aws_ec2_client_vpn_network_association" "private_1a" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  subnet_id              = aws_subnet.private_1a.id
}

resource "aws_ec2_client_vpn_network_association" "private_1c" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  subnet_id              = aws_subnet.private_1c.id
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
resource "aws_ec2_client_vpn_route" "private_1a" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  destination_cidr_block = "0.0.0.0/0"
  target_vpc_subnet_id   = aws_ec2_client_vpn_network_association.private_1a.subnet_id
}

resource "aws_ec2_client_vpn_route" "private_1c" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  destination_cidr_block = "0.0.0.0/0"
  target_vpc_subnet_id   = aws_ec2_client_vpn_network_association.private_1c.subnet_id
}
