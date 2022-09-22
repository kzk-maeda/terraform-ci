remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "kzk-sandbox-terraform-tfstate"

    key = "moved/${path_relative_to_include()}/terragrunt/terraform.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region                  = "ap-northeast-1"
  version                 = "~>4.0"
  shared_credentials_file = ".aws/credential"
  profile                 = "ci"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
EOF
}
