module "networking" {
  source              = "./modules/networking"
  vpc_cidr            = var.vpc_cidr
  vpc_name            = var.vpc_name
  cidr_private_subnet = var.cidr_private_subnet
  cidr_public_subnet  = var.cidr_public_subnet
  availability_zone   = var.availability_zone
}

module "security_groups" {
  source = "./modules/security-groups"
  vpc_id = module.networking.vpc_id
}

module "ec2" {
  source                             = "./modules/ec2"
  instance_name                      = var.instance_name
  instance_type                      = var.instance_type
  subnet_id                          = tolist(module.networking.public_subnets)[0]
  enable_associate_public_ip_address = var.enable_associate_public_ip_address
  user_data_install_script           = templatefile("./template/ec2_install_script.sh", {})
  public_key                         = var.public_key
  sg_enable_ssh_https                = module.security_groups.sg_ec2_http_ssh_id
  ec2_sg_name_for_python_api         = module.security_groups.sg_ec2_python_api_id
}

module "rds" {
  source               = "./modules/rds"
  db_subnet_group_name = var.db_subnet_group_name
  subnet_groups        = tolist(module.networking.private_subnets)
  rds_mysql_sg_id      = module.security_groups.sg_rds_mysql_id
  mysql_db_identifier  = var.db_identifier
  mysql_dbname         = var.db_name
  mysql_username       = var.db_username
  mysql_password       = var.db_password
}

module "lb_target_group" {
  source                   = "./modules/lb-target-group"
  vpc_id                   = module.networking.vpc_id
  ec2_instance_id          = module.ec2.ec2_instance_id
  lb_target_group_name     = var.lb_target_group_name
  lb_target_group_port     = var.app_port
  lb_target_group_protocol = "HTTP"
}

module "lb" {
  source                          = "./modules/lb"
  certificate_arn                 = module.certificate_manager.devops_project_acm_arn
  ec2_instance_id                 = module.ec2.ec2_instance_id
  lb_listner_default_action       = "forward"
  sg_enable_ssh_https             = module.security_groups.sg_ec2_http_ssh_id
  lb_name                         = var.lb_name
  lb_target_group_arn             = module.lb_target_group.devops_project_lb_target_group_arn
  lb_target_group_attachment_port = var.app_port
  lb_type                         = "application"
  subnet_ids                      = tolist(module.networking.public_subnets)
  lb_listner_port                 = var.app_port
  lb_listner_protocol             = "HTTP"
  lb_https_listner_port           = 443
  lb_https_listner_protocol       = "HTTPS"
}

module "hosted_zone" {
  source      = "./modules/hosted-zone"
  lb_dns_name = module.lb.lb_dns_name
  lb_zone_id  = module.lb.lb_zone_id
  hosted_zone = var.hosted_zone
  host_fqdn   = var.host_fqdn
}

module "certificate_manager" {
  source         = "./modules/certificate-manager"
  domain_name    = var.host_fqdn
  hosted_zone_id = module.hosted_zone.hosted_zone_id
}
