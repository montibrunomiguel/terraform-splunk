resource "aws_vpc_endpoint_service" "splunk_search_head" {
  acceptance_required        = true
  network_load_balancer_arns = [aws_lb.splunk_nlb["search-head"].arn]
  allowed_principals         = ["<arn:aws:iam::id:root>"]
}

resource "aws_vpc_endpoint_service" "splunk_master" {
  acceptance_required        = true
  network_load_balancer_arns = [aws_lb.splunk_nlb["master"].arn]
  allowed_principals         = ["<arn:aws:iam::id:root>]
}
