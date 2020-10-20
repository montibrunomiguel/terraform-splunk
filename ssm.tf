resource "aws_ssm_parameter" "splunk_nlb_dns_name" {
  name = "splunk_indexer_nlb_dns_name"
  type = "String"
  value = aws_lb.splunk_indexer_nlb.dns_name
