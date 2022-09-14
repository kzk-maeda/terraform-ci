provider "aws" {
  region                  = "ap-northeast-1"
  version                 = "~>3.0"
  shared_credentials_file = ".aws/credential"
  profile                 = "ci"
  default_tags {
    tags = {
      project = "vpn_client"
    }
  }
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
