 resource "aws_placement_group" "splunk"{
  name     = "splunk"
  strategy = "cluster"
 }
