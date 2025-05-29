variable "alb_subnet_ids" {
  type = list(string)
  description = "public facing subnets"
}

variable "name" {
    type = string
    description = "give alb a name"
}

variable "alb-sg-id" {
    type = string
    description = "SG for port listner"
}

variable "vpc_id" {
    type = string
    description = "vpc id for target group"
}

variable "ssl-policy" {
    type = string
    default = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
    description = "ssl policy"
}

variable "domain_name" {
    type = string
    description = "domain name issued by AWS"
  
}