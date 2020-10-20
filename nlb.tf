#Master & Search Head x Transit Account
resource "aws_lb" "splunk_nlb"{
  for_each = toset(var.splunk_resource)
  name = "splunk-${each.value}-nlb"
  load_balancer_type = "network"
  internal = true
  subnet = [
    var.private_subnet_A_id[var.enviroment],
    var.private_subnet_C_id[var.enviroment]
  ]
  enable_deletion_protection = true
  enable_cross_zone_load_balancing = true
}

#Indexers x Private Subnets
resource "aws_lb" "splunk_indexer_nlb"{
  name = "splunk-indexer-nlb"
  load_balancer_type = "network"
  internal = true
  subnet = [
    var.private_subnet_A_id[var.enviroment],
    var.private_subnet_C_id[var.enviroment]
  ]
  enable_deletion_protection = true
  enable_cross_zone_load_balancing = true
}
