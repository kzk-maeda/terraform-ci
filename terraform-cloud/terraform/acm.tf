# 手動で証明書をACMに登録
data "aws_acm_certificate" "server_certificate" {
  domain = "server"
}

data "aws_acm_certificate" "client_certificate" {
  domain = "client1.domain.tld"
}
