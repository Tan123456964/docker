module "vpc-module" {
  source   = "./vpc"
  vpc_name = "tapon-vpc"
}

module "elb-module" {
  source         = "./alb"
  name           = "tapon-alb"
  alb_subnet_ids = module.vpc-module.subnet_ids
  alb-sg-id      = module.vpc-module.alb-sg-id
  vpc_id         = module.vpc-module.vpc_id
  domain_name    = var.domain_name
}

module "ecs-module" {
  source               = "./ecs"
  ecs_cluster_name     = "tapon-ecs-cluster"
  ecs_subnet_ids       = module.vpc-module.subnet_ids
  ecs-sg-id            = module.vpc-module.esc-sg-id
  alb_target_group_arn = module.elb-module.alb_tgc_arn
}

module "r53-module" {
  source          = "./r53"
  domain_name     = var.domain_name
  alb_domain_name = module.elb-module.alb_domain_name
  alb_zone_id     = module.elb-module.alb_zone_id
}
