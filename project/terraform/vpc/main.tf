
data "aws_availability_zones" "this" {
  state = "available"
}

locals {
  az_names     = data.aws_availability_zones.this.names
  az_count     = length(local.az_names)
}

resource "aws_vpc" "this" {
  cidr_block       = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "this" {
  count             = length(var.vpc_subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.vpc_subnets[count.index].cidr
  availability_zone = local.az_names[count.index % local.az_count]

  tags = {
    Name = var.vpc_subnets[count.index].name
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${var.vpc_name}-rt"
  }
}

resource "aws_route_table_association" "this" {
  count          = length(aws_subnet.this)
  subnet_id      = aws_subnet.this[count.index].id
  route_table_id = aws_route_table.this.id
}



resource "aws_security_group" "elb" {
  name        = "${var.vpc_name}-alb-sg"
  description = "Allow HTTPS inbound for ALB"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "Allow HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.vpc_name}-alb-sg"
  }
}

resource "aws_security_group" "ecs_service" {
  name        = "${var.vpc_name}-ecs-service-sg"
  description = "Allow traffic from ALB to ECS service"
  vpc_id      = aws_vpc.this.id

  ingress {
    description     = "Allow from ALB SG on HTTP"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.elb.id]  # ALB SG
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.vpc_name}-ecs-service-sg"
  }
}



