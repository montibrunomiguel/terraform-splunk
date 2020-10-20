# ================================ SEARCH HEAD ========================================

# Instance Launch Configuration
resource "aws_launch_configuration" "splunk_search_head_lc" {
  name_prefix                 = "splunk_search_head_lc"
  image_id                    = var.splunk_ami_id
  instance_type               = var.splunk_search_head_instanceTypes[var.environment]
  security_groups             = [aws_security_group.splunk_search_head_sg.id, aws_security_group.splunk_sg.id]
  associate_public_ip_address = false
  iam_instance_profile        = "cyberdefense-splunk-role"

  user_data = data.template_file.splunk_search_head_userData.rendered

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "splunk_search_head_asg" {
  availability_zones   = var.availability_zones
  name_prefix          = "splunk_search_head_asg"
  min_size             = 3
  max_size             = 3
  health_check_type    = "EC2"
  launch_configuration = aws_launch_configuration.splunk_search_head_lc.id

  vpc_zone_identifier = [
    var.private_subnet_A_id[var.environment],
    var.private_subnet_C_id[var.environment]
  ]

  tags = [
    {
      key                 = "Name"
      value               = "Splunk-Search_Head"
      propagate_at_launch = true
    },
    {
      key                 = "Product"
      value               = "Splunk"
      propagate_at_launch = true
    }
  ]

  lifecycle {
    create_before_destroy = true
  }

  target_group_arns = [aws_lb_target_group.splunk_alb_tg["search-head"].arn]
}

resource "aws_autoscaling_schedule" "autoscaling_schedule_up_splunk_search_head" {
  scheduled_action_name  = "splunk_search_head_asg_scheduled_up"
  min_size               = 3
  max_size               = 3
  desired_capacity       = 3
  recurrence             = "0 7 * * MON-FRI"
  autoscaling_group_name = aws_autoscaling_group.splunk_search_head_asg.name
}
