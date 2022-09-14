terraform {
  cloud {
    hostname     = "app.terraform.io"
    organization = "kzk-maeda"
    workspaces {
      name = "terraform-cloud-sample"
    }
  }
}
