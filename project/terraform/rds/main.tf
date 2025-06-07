resource "aws_db_subnet_group" "this" {
  name       = "tapon_s_app"
  subnet_ids = var.rds_subnet_ids

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "dev_db" {
  identifier                 = var.db_identifier
  storage_type               = "gp2"
  allocated_storage          = 20
  engine                     = var.engine
  engine_version             = var.engine_version
  instance_class             = var.instance_class
  username                   = var.db_username
  password                   = var.db_password
  db_name                    = var.db_name
  port                       = 3306
  publicly_accessible        = false
  skip_final_snapshot        = true
  deletion_protection        = false
  auto_minor_version_upgrade = true
  multi_az                   = false
  backup_retention_period    = 0

  vpc_security_group_ids = [var.rds_security_group_id]
  db_subnet_group_name   = aws_db_subnet_group.this.name

  tags = {
    Environment = "dev"
  }
}


# creating admin instance to initalize DB
# ssh to this instance and update DB
# run this command : mysql -h <rds-endpoint> -u <username> -p<password> <dbname> < init.sql

resource "aws_instance" "rds_init_host" {
  ami                    = "ami-02457590d33d576c3"
  instance_type          = "t2.micro"
  subnet_id              = var.public_subnet_ids[0]
  vpc_security_group_ids = [var.ec2_security_group_id]
  key_name               = "tkdasSecreat" # You must have created this key in AWS

  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y mariadb105
              EOF

  tags = {
    Name = "rds-init-host"
  }
}

