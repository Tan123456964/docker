variable "ecs_cluster_name" {
  type        = string
  description = "ECS cluster name"

}

variable "ecs_subnet_ids" {
  type        = list(string)
  description = "private subnets subnets"
}

variable "ecs-sg-id" {
  type        = string
  description = "SG for port listner"
}

variable "alb_target_group_arn" {
  type        = string
  description = "alb name"
}

variable "environment" {
  description = "List of environment variables for database"
  type = list(object({
    name  = string
    value = string
  }))
  sensitive = true
}

