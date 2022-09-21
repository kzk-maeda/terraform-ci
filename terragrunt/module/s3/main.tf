resource "aws_s3_bucket" "this" {
  bucket = "${terraform.workspace}-${var.bucket_name}-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "${terraform.workspace}-${var.bucket_name}-${data.aws_caller_identity.current.account_id}"
    Environment = "${terraform.workspace}"
  }
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}
