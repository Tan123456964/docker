output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "subnet_ids" {
  description = "List of all created subnet IDs"
  value       = [for subnet in aws_subnet.this : subnet.id]
}

output "alb-sg-id" {
    description = "SG for ALB"
    value = aws_security_group.elb.id
}

output "esc-sg-id" {
    description = "SG for ALB"
    value = aws_security_group.ecs_service.id
}
