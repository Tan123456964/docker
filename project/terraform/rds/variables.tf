variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
}

variable "db_identifier" {
  description = "Database identifier is quniqe"
  type        = string
}

variable "rds_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "engine" {
  description = "The database engine"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "The database engine version"
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "The instance type of the RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "rds_security_group_id" {
  description = "Security group ID to associate with the RDS instance"
  type        = string
}

variable "ec2_security_group_id" {
  description = "The ID of the security group to associate with the EC2 instance"
  type        = string
}

variable "public_subnet_ids" {
  description = "It is used to launch ec2 instance in public subnet"
  type        = list(string)
}

variable "db_name" {
  type = string
  description = "database name"
  
}
