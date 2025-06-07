data "aws_ssm_parameter" "db_user" {
  name = "/dev/db/username"
}
data "aws_ssm_parameter" "db_password" {
  name = "/dev/db/password"
}
data "aws_ssm_parameter" "db_name" {
  name = "/dev/db/db_name"
}

resource "random_string" "db_identifier" {
  length  = 8
  upper   = false
  special = false
}

data "aws_availability_zones" "this" {
  state = "available"
}

module "vpc-module" {
  source   = "./vpc"
  vpc_name = "tapon-vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_bublic_subnets = [
    { name = "sn-public-1", cidr = "10.0.1.0/24" },
    { name = "sn-public-2", cidr = "10.0.2.0/24" },
    { name = "sn-public-3", cidr = "10.0.3.0/24" }
  ]
  vpc_private_subnets = [
    { name = "sn-private-1", cidr = "10.0.4.0/24" },
    { name = "sn-private-2", cidr = "10.0.5.0/24" },
    { name = "sn-private-3", cidr = "10.0.6.0/24" }
  ]
  availability_zone_list = slice(data.aws_availability_zones.this.names, 0, 3) # 3 AZs
}

module "elb-module" {
  depends_on     = [module.vpc-module]
  source         = "./alb"
  name           = "tapon-alb"
  alb_subnet_ids = module.vpc-module.public_subnet_ids
  alb-sg-id      = module.vpc-module.alb-sg-id
  vpc_id         = module.vpc-module.vpc_id
  domain_name    = var.domain_name
}

module "ecs-module" {
  depends_on           = [module.elb-module, module.rds-module]
  source               = "./ecs"
  ecs_cluster_name     = "tapon-ecs-cluster"
  ecs_subnet_ids       = module.vpc-module.private_subnet_ids
  ecs-sg-id            = module.vpc-module.esc-sg-id
  alb_target_group_arn = module.elb-module.alb_tgc_arn
  environment = [
    { name = "DB_HOST", value = module.rds-module.rds_endpoint },
    { name = "DB_USER", value = data.aws_ssm_parameter.db_user.value },
    { name = "DB_PASSWORD", value = data.aws_ssm_parameter.db_password.value },
    { name = "DB_NAME", value = data.aws_ssm_parameter.db_name.value },
    { name = "DB_PORT", value = tostring(3306) }
  ]
}

module "r53-module" {
  depends_on      = [module.elb-module]
  source          = "./r53"
  domain_name     = var.domain_name
  alb_domain_name = module.elb-module.alb_domain_name
  alb_zone_id     = module.elb-module.alb_zone_id
}

module "rds-module" {
  depends_on = [ module.vpc-module ]
  source                = "./rds"
  db_identifier         = "db${random_string.db_identifier.result}"
  db_password           = data.aws_ssm_parameter.db_password.value
  db_username           = data.aws_ssm_parameter.db_user.value
  db_name               = data.aws_ssm_parameter.db_name.value
  rds_subnet_ids        = module.vpc-module.private_subnet_ids
  rds_security_group_id = module.vpc-module.rds-sg-id
  ec2_security_group_id = module.vpc-module.ec2-sg-id
  public_subnet_ids     = module.vpc-module.public_subnet_ids
}