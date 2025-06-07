resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  count             = length(var.vpc_bublic_subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.vpc_bublic_subnets[count.index].cidr
  availability_zone = var.availability_zone_list[count.index % length(var.availability_zone_list)]

  tags = {
    Name = var.vpc_bublic_subnets[count.index].name
  }
}

resource "aws_subnet" "private" {
  count             = length(var.vpc_private_subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.vpc_private_subnets[count.index].cidr
  availability_zone = var.availability_zone_list[count.index % length(var.availability_zone_list)]

  tags = {
    Name = var.vpc_private_subnets[count.index].name
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "${var.vpc_name}-nat"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.this]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${var.vpc_name}-rt"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = {
    Name = "${var.vpc_name}-private-rt"
  }
}


resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
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
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.elb.id] # ALB SG
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

data "http" "my_ip" {
  url = "https://checkip.amazonaws.com"
}

resource "aws_security_group" "ec2_sg" {
  name        = "${var.vpc_name}-admin-instance-sg"
  description = "Allow SSH and RDS access"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "Allow SSH from your IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ip.response_body)}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.vpc_name}-ec2-sg"
  }
}


resource "aws_security_group" "rds_sg" {
  name        = "${var.vpc_name}-rds-sg"
  description = "Allow traffic from Admin ec2 instance and ecs task"
  vpc_id      = aws_vpc.this.id

  ingress {
    description     = "Allow from ALB SG on HTTP"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_service.id, aws_security_group.ec2_sg.id] 
  }


  # egress {
  #   description = "Allow all outbound traffic"
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  tags = {
    Name = "${var.vpc_name}-ecs-service-sg"
  }
}

# resource "aws_security_group" "rds_sg" {
#   name        = "${var.vpc_name}-rds-sg"
#   description = "Allow traffic my IP and ecs task"
#   vpc_id      = aws_vpc.this.id

#   tags = {
#     Name = "${var.vpc_name}-ecs-service-sg"
#   }
# }

# resource "aws_security_group_rule" "mysql_ingress" {
#   from_port                = 3306
#   to_port                  = 3306
#   protocol                 = "tcp"
#   security_group_id        = aws_security_group.rds_sg.id
#   cidr_blocks              = [aws_vpc.this.cidr_block]
#   type                     = "ingress"
# }

# resource "aws_security_group_rule" "mysql_egress" {
#   cidr_blocks       = [aws_vpc.this.cidr_block]
#   from_port         = 0
#   protocol          = "-1"
#   security_group_id = aws_security_group.rds_sg.id
#   to_port           = 0
#   type              = "egress"
# }


