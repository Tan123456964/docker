variable "region" {
  type = string
  default = "us-east-1"
  description = "specify regin where to deploy your infrastracture"
}

variable "domain_name" {
  type = string
  description = "AWS issued domain name"
  default = "tanmoydas.link"
}