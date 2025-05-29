output "alb_tgc_arn" {
    value = aws_lb_target_group.this.arn
    description = "target group arn"
}

output "alb_domain_name" {
    value = aws_lb.alb.dns_name
    description = "used by r53 cname record"
}

output "alb_zone_id" {
    value = aws_lb.alb.zone_id
    description = "used to create a A record"
}