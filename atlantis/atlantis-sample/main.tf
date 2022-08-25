resource "aws_s3_bucket" "bucket" {
  bucket = "terraform-ci-test-backet-terraform-cloud-kzkmaeda"

  tags = {
    Name        = "terraform-ci-test-backet-terraform-cloud-kzkmaeda"
    Environment = "changed2"
  }
}

resource "aws_s3_bucket_acl" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}