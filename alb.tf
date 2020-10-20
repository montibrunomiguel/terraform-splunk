#Master & Seach Head x NLB to Transit Account
resource "aws_lb" "splunk_alb"{
    for_each = toset(var.splunk_resource)
    name = "splunk-${each.value}-alb"
    internal = true
    load_balancer_type = "application"
    security_groups = [aws_security_group.splunk_sg.id, aws_security_group.splunk_alb_sg.id]
  
    subnet = [
      var.private_subnet_A_id[var.environment],
      var.private_subnet_C_id[var.environment]
    ]
    
    enable_deletion_protection = true
  
    tags = {
      Name = "Splunk_${each.value}_Lb"
    }
  }

#Deployer
resource "aws_lb" "splunk_deployer_alb"{
    name = "splunk-deployer-alb"
    internal = true
    load_balancer_type = "application"
    security_groups = [aws_security_group.splunk_sg.id, aws_security_group.splunk_alb_sg.id]
  
    subnet = [
      var.private_subnet_A_id[var.environment],
      var.private_subnet_C_id[var.environment]
    ]
    
    enable_deletion_protection = true
  
    tags = {
      Name = "Splunk_Deployer_Lb"
    }
  }
