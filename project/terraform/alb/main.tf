data "aws_s3_bucket" "this" {
  bucket = "aws-logs-471112707783-us-east-1"
}

data "aws_acm_certificate" "cert" {
  domain      = var.domain_name
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

resource "aws_lb" "alb" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb-sg-id]
  subnets            = var.alb_subnet_ids

  access_logs {
    bucket  = data.aws_s3_bucket.this.id
    prefix  = "access-logs"
    enabled = true
  }

  tags = {
    Environment = "production"
  }
}


resource "aws_lb_target_group" "this" {
  name        = "${var.name}-target-group"
  port        = 443
  protocol    = "HTTPS"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 30
    path                = "/"
    protocol            = "HTTPS"
    matcher             = "200"
  }

  tags = {
    Name = "ip-target-group"
  }
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl-policy
  certificate_arn   = data.aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}







