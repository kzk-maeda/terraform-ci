# VPC - use these parameters to create new VPC resources
cidr = "10.10.0.0/16"

azs = ["ap-northeast-1a", "ap-northeast-1c"]

private_subnets = ["10.10.1.0/24", "10.10.2.0/24"]

public_subnets = ["10.10.11.0/24", "10.10.12.0/24"]

# VPC - use these parameters to use existing VPC resources
# vpc_id = "vpc-1651acf1"
# private_subnet_ids = ["subnet-1fe3d837", "subnet-129d66ab"]
# public_subnet_ids = ["subnet-1211eef5", "subnet-163466ab"]

# DNS
route53_zone_name = "kzk-maeda.work"

# ACM (SSL certificate)
# Specify ARN of an existing certificate or new one will be created and validated using Route53 DNS:
# certificate_arn = "arn:aws:acm:eu-west-1:135367859851:certificate/70e008e1-c0e1-4c7e-9670-7bb5bd4f5a84"

# ECS Service and Task
ecs_service_assign_public_ip = true

# Atlantis
atlantis_repo_allowlist = ["github.com/kzk-maeda/terraform-ci"]

# Tags
tags = {
  Name = "atlantis"
  Env = "atlantis"
}
