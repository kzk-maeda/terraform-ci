terraform {
  cloud {
    hostname = "app.terraform.io"
    organization = "kzk-maeda"
    workspaces {
      name = "terraform-cloud-sample"
    }
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
