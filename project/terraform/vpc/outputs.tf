output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "List of all created public subnet IDs"
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnet_ids" {
  description = "List of all created private subnet IDs"
  value       = [for subnet in aws_subnet.private : subnet.id]
}

output "alb-sg-id" {
  description = "ALB sg id"
  value       = aws_security_group.elb.id
}

output "esc-sg-id" {
  description = "ECS sg id"
  value       = aws_security_group.ecs_service.id
}

output "rds-sg-id" {
  description = "RDS sg id"
  value       = aws_security_group.rds_sg.id
}

output "ec2-sg-id" {
  description = "ECS sg id"
  value       = aws_security_group.ec2_sg.id
}