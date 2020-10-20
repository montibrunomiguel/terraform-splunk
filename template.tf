data "template_file" "splunk_master_userData" {
  template = file("${path.module}/data/splunk_master_userData")

  vars = {
    splunk_master = data.aws_s3_bucket.splunk_s3["master"].id
    splunk_license = data.aws_s3_bucket.splunk_s3_license.id
    cyberdefense_endpoint = var.cyberdefense_endpoint[var.environment]
    admin_password = data.aws_secretsmanager_secret_version.splunk_admin_password_version.secret_string
  }
}

data "template_file" "splunk_indexer_userData" {
  template = file("${path.module}/data/splunk_indexer_userData")

  vars = {
    private_subnet_1 = var.private_subnet_A_id[var.environment]
    private_subnet_2 = var.private_subnet_C_id[var.environment]
    admin_password = data.aws_secretsmanager_secret_version.splunk_admin_password_version.secret_string
  }
}

data "template_file" "splunk_deployer_userData" {
  template = file("${path.module}/data/splunk_deployer_userData")

  vars = {
    splunk_search_head         = data.aws_s3_bucket.splunk_s3["search-head"].id
    cyberdefense_endpoint = var.cyberdefense_endpoint[var.environment]
    private_subnet_1 = var.private_subnet_A_id[var.environment]
    private_subnet_2 = var.private_subnet_C_id[var.environment]
    admin_password = data.aws_secretsmanager_secret_version.splunk_admin_password_version.secret_string
  }
}

data "template_file" "splunk_search_head_userData" {
  template = file("${path.module}/data/splunk_search_head_userData")

  vars = {
    cyberdefense_endpoint = var.cyberdefense_endpoint[var.environment]
    private_subnet_1 = var.private_subnet_A_id[var.environment]
    private_subnet_2 = var.private_subnet_C_id[var.environment]
    ldap_user = data.aws_secretsmanager_secret_version.splunk_ldap_username_version.secret_string
    ldap_password = data.aws_secretsmanager_secret_version.splunk_ldap_password_version.secret_string
    admin_password = data.aws_secretsmanager_secret_version.splunk_admin_password_version.secret_string
  }
}
