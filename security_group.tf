resource "aws_security_group" "splunk_search_head_sg"{
  name        = "splunk_search_head_sg"
  description = "Splunk Search Head Security Group"
  vpc_id      = var.vpc_id[var.environment]
  
  tags = {
    Name = "splunk_search_head_sg"
  }
  
}

resource "aws_security_group_rule" "splunk_search_head_sg-Allow-Egress-Ldap-VpcEndpoint" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.splunk_search_head_sg.id
  source_security_group_id = data.aws_security_group.ldap_vpc_endpoint_secure_group.id
}

resource "aws_security_group_rule" "splunk_search_head_sg-Ingress_web_interface" {
  type                     = "ingress"
  from_port                = 8000
  to_port                  = 8000
  protocol                 = "tcp"
  cidr_blocks        = [var.vpc_cidr[var.enviroment]]
  security_group_id = aws_security_group.splunk_search_head_sg.id
}

resource "aws_security_group_rule" "splunk_search_head_sg-Ingress_shc_replication" {
  type                     = "ingress"
  from_port                = 8090
  to_port                  = 8090
  protocol                 = "tcp"
  cidr_blocks       = [var.vpc_cidr[var.enviroment]]
  security_group_id = aws_security_group.splunk_search_head_sg.id
}

resource "aws_security_group_rule" "splunk_search_head_sg-Ingress_api" {
  type                     = "ingress"
  from_port                = 8089
  to_port                  = 8089
  protocol                 = "tcp"
  cidr_blocks        = [var.vpc_cidr[var.enviroment]]
  security_group_id = aws_security_group.splunk_search_head_sg.id
}

resource "aws_security_group_rule" "splunk_search_head_sg-Ingress_kvstore" {
  type                     = "ingress"
  from_port                = 8191
  to_port                  = 8191
  protocol                 = "tcp"
  cidr_blocks        = [var.vpc_cidr[var.enviroment]]
  security_group_id = aws_security_group.splunk_search_head_sg.id
}

resource "aws_security_group_rule" "splunk_search_head_sg-Allow-Egress-All" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  cidr_blocks        = [var.vpc_cidr[var.environment]]
  security_group_id = data.aws_security_group.splunk_search_head_sg.id
}

# ==========================================================================

resource "aws_security_group" "splunk_indexers_sg"{
  name        = "splunk_indexers_sg"
  description = "Splunk Indexers Security Group"
  vpc_id      = var.vpc_id[var.environment]
  
  tags = {
    Name = "splunk_indexers_sg"
  }
  
}

# ============================== INDEXERS ===================================

resource "aws_security_group_rule" "splunk_indexers_sg-Allow-Egress-Ldap-VpcEndpoint" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.splunk_indexers_sg.id
  source_security_group_id = data.aws_security_group.ldap_vpc_endpoint_secure_group.id
}

resource "aws_security_group_rule" "splunk_indexers_sg-Allow-Ingress_splunk_tcp_input" {
  type                     = "ingress"
  from_port                = 9997
  to_port                  = 9997
  protocol                 = "tcp"
  cidr_blocks        = [var.vpc_cidr[var.environment]]
  security_group_id = aws_security_group.splunk_indexers_sg.id
}

resource "aws_security_group_rule" "splunk_indexers_sg-Allow-Ingress_splunk_hec_input" {
  type                     = "ingress"
  from_port                = 8088
  to_port                  = 8088
  protocol                 = "tcp"
  cidr_blocks        = [var.vpc_cidr[var.environment]]
  security_group_id = aws_security_group.splunk_indexers_sg.id
}

resource "aws_security_group_rule" "splunk_indexers_sg-Allow-Ingress_splunk_tcp_udp_input" {
  type                     = "ingress"
  from_port                = 514
  to_port                  = 514
  protocol                 = "tcp"
  cidr_blocks        = [var.vpc_cidr[var.environment]]
  security_group_id = aws_security_group.splunk_indexers_sg.id
}

resource "aws_security_group_rule" "splunk_indexers_sg-Allow-Ingress_splunk_data_replication" {
  type                     = "ingress"
  from_port                = 9887
  to_port                  = 9887
  protocol                 = "tcp"
  cidr_blocks        = [var.vpc_cidr[var.environment]]
  security_group_id = aws_security_group.splunk_indexers_sg.id
}

resource "aws_security_group_rule" "splunk_indexers_sg-Allow-Egress-All" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  cidr_blocks        = [var.vpc_cidr[var.environment]]
  security_group_id = data.aws_security_group.splunk_indexers_sg.id
}

# ==========================================================================

resource "aws_security_group" "splunk_sg"{
  name        = "splunk_sg"
  description = "Splunk Security Group"
  vpc_id      = var.vpc_id[var.environment]
  
  tags = {
    Name = "splunk_sg"
  }
  
}

resource "aws_security_group_rule" "splunk_indexers_sg-Allow-Egress-Ldap-VpcEndpoint" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.splunk_sg.id
  security_group_id = data.aws_security_group.ldap_vpc_endpoint_secure_group.id
}

resource "aws_security_group_rule" "splunk_sg-Allow-Ingress_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  cidr_blocks        = [var.vpc_cidr[var.environment]]
  security_group_id = aws_security_group.splunk_sg.id
}

resource "aws_security_group_rule" "splunk_sg-Allow-Ingress_admin" {
  type                     = "ingress"
  from_port                = 8089
  to_port                  = 8089
  protocol                 = "tcp"
  cidr_blocks        = [var.vpc_cidr[var.environment]]
  security_group_id = aws_security_group.splunk_sg.id
}

resource "aws_security_group_rule" "splunk_sg-Allow-Ingress_web_interface" {
  type                     = "ingress"
  from_port                = 8000
  to_port                  = 8000
  protocol                 = "tcp"
  cidr_blocks        = [var.vpc_cidr[var.environment]]
  security_group_id = aws_security_group.splunk_sg.id
}

resource "aws_security_group_rule" "splunk_sg-Allow-Egress-All" {
  type               = "egress"
  from_port          = 0
  to_port            = 0
  protocol           = "-1"
  cidr_blocks        = [var.vpc_cidr[var.environment]]
  security_group_id  = aws_security_group.splunk_sg.id
}

resource "aws_security_group_rule" "splunk_indexers_sg-Allow-Egress-To-S3" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  prefix_list_ids   = [data.aws_vpc_endpoint.s3_private_vpc_endpoint.prefix_list_id]
  security_group_id = aws_security_group.splunk_sg.id
}

# ==========================================================================

resource "aws_security_group" "splunk_hec_loadbalance_sg"{
  name        = "splunk_hec_loadbalance_sg"
  description = "Splunk HEC Load Balance Security Group"
  vpc_id      = var.vpc_id[var.environment]
  
  tags = {
    Name = "splunk_hec_loadbalance_sg"
  }
  
}

resource "aws_security_group_rule" "splunk_hec_loadbalance_sg-Ingress_hec_loadbalance {
  type                     = "ingress"
  from_port                = 8088
  to_port                  = 8088
  protocol                 = "tcp"
  cidr_blocks        = [var.vpc_cidr[var.environment]]
  security_group_id = aws_security_group.splunk_hec_loadbalance.id
}

#Define SecureGroup
resource "aws_security_group" "splunk_alb_sg"{
  name        = "splunk_alb_sg"
  description = "Secure Group do Balanceador de Transito"
  vpc_id      = var.vpc_id[var.environment]
  
  tags = {
    Name = "Splunk-TransitAccountIntegration"
  }
}

#Ingress Public HTTPS
resource "aws_security_group_rule" "splunk_alb_sg-Allow-All-Ingress-HTTPS"{
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  cidr_blocks        = concat(var.public_itau_cidrs,[var.vpc_cidr[var.environment]])
  security_group_id = aws_security_group.splunk_hec_loadbalance.id

}

#AD Access
data "aws_security_group" "ldap_vpc_endpoint_secure_group" {
  tags = {
    Name = "ad itau ldap"
  }
}
