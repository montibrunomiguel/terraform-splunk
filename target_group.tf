### SPLUNK NLB TARGET GROUP ###
resource "aws_lb_target_group" "splunk_nlb_tg" {
  for_each = toset(var.splunk_resource)
  name = "splunk-nlb-${each.value}-tg"
  port        = 443
  protocol    = "TCP"
  target_type = "ip"
  vpc_id = var.vpc_id[var.environment]
  tags = {
    Name    = "Splunk_NLB_${each.value}"
  }
}

resource "aws_lb_listener" "splunk_nlb_listener" {
  for_each = toset(var.splunk_resource)
  load_balancer_arn = aws_lb.splunk_nlb[each.value].arn
  port = 443
  protocol = "TCP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.splunk_nlb_tg[each.value].arn
  }
}

### SPLUNK ALB TARGET GROUP ###
# ALB
resource "aws_lb_target_group" "splunk_alb_tg" {
  for_each = toset(var.splunk_resource)
  name = "splunk-alb-${each.value}-tg"
  port        = 8000
  protocol    = "HTTPS"
  vpc_id      = var.vpc_id[var.environment]
  target_type = "instance"

  health_check {
    interval            = 30
    path                = "/en-US/account/login?return_to=%2Fen-US%2F"
    port                = 8000
    protocol            = "HTTPS"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }
  stickiness {
    cookie_duration = 1800
    type = "lb_cookie"
  }
  tags = {
    Name    = "Splunk_${each.value}"
  }
}

resource "aws_lb_listener" "splunk_alb_listener" {
  for_each = toset(var.splunk_resource)
  load_balancer_arn = aws_lb.splunk_alb[each.value].arn
  port = 443
  protocol = "HTTPS"
  certificate_arn   = var.certificate_arns[var.environment]

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.splunk_alb_tg[each.value].arn
  }
}

# NLB Indexers
resource "aws_lb_target_group" "splunk_nlb_indexer_tg" {
  name = "splunk-nlb-indexer-tg--hec"
  port = 8088
  protocol = "TCP"
  target_type = "instance"
  vpc_id = var.vpc_id[var.environment]

  tags = {
    Name    = "samaritanSplunkHEC"
  }

  #health_check = {
  #    path: "HTTPS:8088/services/collector/health"
  #    healthy_threshold = 3
  #    unhealthy_threshold = 2
  #    interval = 20
  #    timeout = 5
  #}
}

resource "aws_lb_listener" "splunk_nlb_indexer_listener" {
  load_balancer_arn = aws_lb.splunk_indexer_nlb.arn
  port = 8088
  protocol = "TCP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.splunk_nlb_indexer_tg.arn
  }
}

# ALB Deployer
resource "aws_lb_target_group" "splunk_alb_deployer_tg" {
  name = "splunk-alb-deployer-tg"
  port        = 8000
  protocol    = "HTTPS"
  vpc_id      = var.vpc_id[var.environment]
  target_type = "instance"

  health_check {
    interval            = 30
    path                = "/en-US/account/login?return_to=%2Fen-US%2F"
    port                = 8000
    protocol            = "HTTPS"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name    = "Splunk_Deployer"
  }
}

resource "aws_lb_listener" "splunk_alb_deployer_listener" {
  load_balancer_arn = aws_lb.splunk_deployer_alb.arn
  port = 443
  protocol = "HTTPS"
  certificate_arn   = var.certificate_arns[var.environment]

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.splunk_alb_deployer_tg.arn
  }
}
