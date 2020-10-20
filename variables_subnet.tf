# VPC SubNets Related Variables

###### Private SubNet CIDR ######

variable "private_subnet_A_cidr" {
  description = "Private SubNet A CIDR Block for IPV4"

  default = {
    develop = <CIDR Block>
    stage   = <CIDR Block>
    prod    = <CIDR Block>
  }
}

variable "private_subnet_C_cidr" {
  description = "Private SubNet C CIDR Block for IPV4"

  default = {
    develop = <CIDR Block>
    stage   = <CIDR Block>
    prod    = <CIDR Block>
  }
}

###### Private SubNet ID ######

variable "private_subnet_A_id" {
  description = "Private SubNet A ID"

  default = {
    develop = <Subnet ID>
    stage   = <Subnet ID>
    prod    = <Subnet ID>
  }
}

variable "private_subnet_C_id" {
  description = "Private SubNet C ID"

  default = {
    develop = <Subnet ID>
    stage   = <Subnet ID>
    prod    = <Subnet ID>
  }
}
