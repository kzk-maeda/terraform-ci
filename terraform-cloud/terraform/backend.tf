terraform {
  backend "s3" {
    bucket = "kzk-sandbox-terraform-tfstate"
    key    = ".tfstate/services/terraform-cloud"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region                   = "ap-northeast-1"
  version                  = "~>3.0"
  shared_credentials_file  = ".aws/credential"
  profile                  = "ci"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
