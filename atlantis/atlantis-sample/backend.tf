terraform {
  backend "s3" {
    bucket   = "kzk-sandbox-terraform-tfstate"
    key      = "workspace/atlantis-sample"
    region   = "ap-northeast-1"
    role_arn = "arn:aws:iam::728291782722:role/atlantis-ecs_task_execution"
    # can't use var.atlantis_user as the session name because
    # interpolations are not allowed in backend configuration
    # session_name = "${var.atlantis_user}" WON'T WORK
  }
}

provider "aws" {
  region                   = "ap-northeast-1"
  version                  = "~>3.0"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
