resource "aws_s3_bucket" "this" {
  bucket = "${var.env}-${var.bucket_name}-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "${var.env}-${var.bucket_name}-${data.aws_caller_identity.current.account_id}"
    Environment = "${var.env}"
  }
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}
