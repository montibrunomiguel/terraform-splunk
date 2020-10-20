# ============================== DEPLOYER ==================================

# Instance Launch Configuration
resource "aws_launch_configuration" "splunk_deployer_lc" {
  name_prefix                 = "splunk_deployer_lc"
  image_id                    = var.splunk_ami_id
  instance_type               = var.splunk_deployer_instanceTypes[var.environment]
  security_groups             = [aws_security_group.splunk_indexers_sg.id, aws_security_group.splunk_sg.id]
  associate_public_ip_address = false
  iam_instance_profile        = <iam_role_name>

  user_data = data.template_file.splunk_deployer_userData.rendered

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "splunk_deployer_asg" {
  availability_zones   = var.availability_zones
  name_prefix          = "splunk_deployer_asg"
  min_size             = 1
  max_size             = 1
  health_check_type    = "EC2"
  launch_configuration = aws_launch_configuration.splunk_deployer_lc.id

  vpc_zone_identifier = [
    var.private_subnet_A_id[var.environment],
    var.private_subnet_C_id[var.environment]
  ]

  tags = [
    {
      key                 = "Name"
      value               = "Splunk-Deployer"
      propagate_at_launch = true
    },
    {
      key                 = "Product"
      value               = "Splunk"
      propagate_at_launch = true
    },
  ]

  lifecycle {
    create_before_destroy = true
  }

  target_group_arns = [aws_lb_target_group.splunk_alb_deployer_tg.arn]
}

resource "aws_autoscaling_schedule" "autoscaling_schedule_up_splunk_deployer" {
  scheduled_action_name  = "splunk_deployer_asg_scheduled_up"
  min_size               = 1
  max_size               = 1
  desired_capacity       = 1
  recurrence             = "0 7 * * MON-FRI"
  autoscaling_group_name = aws_autoscaling_group.splunk_deployer_asg.name
}

