variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_bublic_subnets" {
  description = "List of public subnet objects with name and CIDR"
  type = list(object({
    name = string
    cidr = string
  }))
}

variable "vpc_private_subnets" {
  description = "List of private subnet objects with name and CIDR"
  type = list(object({
    name = string
    cidr = string
  }))
}

variable "availability_zone_list" {
  type        = list(string)
  description = "list of AZS will be used to create public and private SN"
}





