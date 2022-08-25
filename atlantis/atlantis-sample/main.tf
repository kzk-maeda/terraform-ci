resource "aws_s3_bucket" "bucket" {
  bucket = "terraform-ci-test-backet-atlantis-kzkmaeda"

  tags = {
    Name        = "terraform-ci-test-backet-atlantis-kzkmaeda"
    Environment = "change"
  }
}

resource "aws_s3_bucket_acl" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}