resource "aws_cloudwatch_log_group" "vpn" {
  name = "vpn"
}

resource "aws_cloudwatch_log_stream" "vpn" {
  name           = "VPNLogStream"
  log_group_name = aws_cloudwatch_log_group.vpn.name
}
