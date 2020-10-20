# Account VPC Related Variables

variable "vpc_cidr" {
  description = "VPC CIDR for IPV4"

  default = {
    develop = <VPC CIDR for IPV4>
    stage   = <VPC CIDR for IPV4>
    prod    = <VPC CIDR for IPV4>
  }
}

variable "vpc_id" {
  description = "VPC ID"

  default = {
    develop = <VPC_ID>
    stage   = <VPC_ID>
    prod    = <VPC_ID>
  }
}

variable "routing_tables_private" {
  description = "List of All Private Routing Tables"

  default = {
    develop = [<routing_tables_private>, routing_tables_private]
    stage   = [<routing_tables_private>, routing_tables_private]
    prod    = [<routing_tables_private>, routing_tables_private]
  }
}
