terraform {
  backend "s3" {
    bucket = "kzk-sandbox-terraform-tfstate"
    key    = "terragrunt/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
