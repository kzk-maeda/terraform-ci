module "s3" {
  source      = "./module/s3"
  bucket_name = var.bucket_name
  env         = terraform.workspace
}
