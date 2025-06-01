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
  depends_on           = [module.elb-module]
  source               = "./ecs"
  ecs_cluster_name     = "tapon-ecs-cluster"
  ecs_subnet_ids       = module.vpc-module.private_subnet_ids
  ecs-sg-id            = module.vpc-module.esc-sg-id
  alb_target_group_arn = module.elb-module.alb_tgc_arn
}

module "r53-module" {
  depends_on      = [module.elb-module]
  source          = "./r53"
  domain_name     = var.domain_name
  alb_domain_name = module.elb-module.alb_domain_name
  alb_zone_id     = module.elb-module.alb_zone_id
}
