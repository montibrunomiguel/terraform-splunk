variable "aws_region" {
  description = "Region for execute Infra as Code"
  default     = "sa-east-1"
}
variable "environment" {}

variable "splunk_search_head_instanceTypes" {
  description = "Instance Type for Splunk environment"

  default = {
    develop = "t3.medium"
    stage   = "t3.medium"
    prod    = "c5d.4xlarge"
  }
}

variable "splunk_indexers_instanceTypes" {
  description = "Instance Type for Splunk environment"

  default = {
    develop = "t3.xlarge"
    stage   = "t3.xlarge"
    prod    = "i3.4xlarge"
  }
}

variable "splunk_master_instanceTypes" {
  description = "Instance Type for Splunk environment"

  default = {
    develop = "t3.medium"
    stage   = "t3.medium"
    prod    = "c5.2xlarge"
  }
}

variable "splunk_deployer_instanceTypes" {
  description = "Instance Type for Splunk environment"

  default = {
    develop = "t3.medium"
    stage   = "t3.medium"
    prod    = "c5d.2xlarge"
  }
}

# splunk_ami_if for Sao Paulo Region
variable "splunk_ami_id" {
  description = "AMI Id Splunk"

  default = "ami-07ba7a3bafe11caf2"
}

variable "splunk_resource" {
  default = ["search-head", "master"]
}

variable "cyberdefense_endpoint" {
  description = "Default endpoint cyberdefense by environment"

  default = {
    develop = "<dev_end_point>"
    stage   = "<hom_end_point>"
    prod    = "<prod_end_point>"
  }
}

# Cluster samaritan
variable "availability_zones" {
  description = "Availability Zones for ECS Cluster"
  default     = ["sa-east-1a", "sa-east-1c"]
}

variable "certificate_arns"{
  description = "Certificates emitted for each environment"

  default = {
    develop = <certificate arn for develop>
    stage   = <certificate arn for stage>
    prod    = <certificate arn for prod>
  }
}

variable "lambda_iam_role_arn" {
  default = {
    develop = <lambda_iam_role_arn>
    stage   = <lambda_iam_role_arn>
    prod    = <lambda_iam_role_arn>
  }
}

variable "public_itau_cidrs" {
  default = [
    <public cidrs IP>
  ]
}
