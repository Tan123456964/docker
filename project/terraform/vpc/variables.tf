variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
  default     = "personal-project"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_subnets" {
  description = "List of subnet objects with name and CIDR"
  type = list(object({
    name = string
    cidr = string
  }))
  default = [
    { name = "sn-1", cidr = "10.0.0.0/24" },
    { name = "sn-2", cidr = "10.0.1.0/24" },
    { name = "sn-3", cidr = "10.0.2.0/24" }
  ]
}





