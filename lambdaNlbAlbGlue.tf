#Infrastructure needed to update the NLB target group with the ALB IP addresses

#Create the lambda funciton that will update the NLB target group with the ALB IP addresses

resource "aws_lambda_function" "populate_nlb_tg_with_alb"{
  for_each      = toset(var.splunk_resource)
  function_name = "splunk-${each.value}-populate-nlb-tg-with-alb"
  filename      = "${path.module}/lambda/populate_NLB_TG_with_ALB.zip"
  description   = "Populate the NLB target group with the ALB IP addreses"
  role          = var.lambda_iam_role_arn[var.environment]
  handler       = "populate_NLB_TG_with_ALB.lambda_handler"
  
  source_code_hash = filebase64sha256("${path.module}/lambda/populate_NLB_TG_with_ALB.zip")
  
  runtime     = "python2.7"
  memory_size = 128
  timeout     = 300
  
  environment {
    variables = {
        ALB_DNS_NAME                     = aws_lb.splunk_alb[each.value].dns_name
        ALB_LISTENER                     = "443"
        S3_BUCKET                        = data.aws_s3_bucket.splunk_s3_lambda[each.value].id
        NLB_TG_ARN                       = aws_lb_target_group.splunk.nlb_tg[each.value].arn
        MAX_LOOKUP_PER_INVOCATION        = 50
        INVOCATIONS_BEFORE_DEREGISTATION = 2
        CW_METRIC_FLAG_IP_COUNT          = true
      }
    }
  }

#Create Cloudwatch events to trigger the lambda function periodically
resource "aws_cloudwatch_event_rule" "cron_minute"{
  for_each            = toset(var.splunk_resource)
  name                = "splunk-${each.value}-cron-minute"
  schedule_expression = "rate(1 minute)"
  is_enabled          = true
  }

resource "aws_cloudwatch_event_target" "populate_nlb_tg_with_alb"{
  for_each  = toset(var.splunk_resource)
  rule      = aws_cloudwatch_event_rule.cron_minute[each.value].name
  target_id = "PopulateNlbTgWithAlbIps"
  arn       = aws_lambda_function.populate_nlb_tg_with_alb[each.value].arn
  }

# Add permission to the lambda function to allow it to be triggered by CloudWatch
resource "aws_lambda_permission" "allow_cloudwatch_trigger"{
  for_each      = toset(var.splunk_resource)
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.populate_nlb_tg_with_alb[each.value].function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cron_minute[each.value].arn
  }
