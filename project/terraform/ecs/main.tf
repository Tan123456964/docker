resource "aws_ecs_cluster" "this" {
  name = var.ecs_cluster_name
  tags = {
    Type = "fargate"
  }
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name = aws_ecs_cluster.this.name

  capacity_providers = ["FARGATE_SPOT"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"

  }
}


resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/project"
  retention_in_days = 7
}


resource "aws_ecs_task_definition" "this" {
  family                   = "myapp-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "2048"
  execution_role_arn       = aws_iam_role.execution-role.arn
  

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "ARM64"
  }

  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "tankman2023/app:fix-latest4"
      essential = false
      portMappings = [
        {
          containerPort = 3000
          protocol      = "tcp"
        }
      ],
      environment = var.environment,
      command     = ["npm", "run", "start"],
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "${aws_cloudwatch_log_group.ecs_logs.name}"
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "app"
        }
      }
    },
    {
      name      = "web"
      image     = "tankman2023/web:latest"
      essential = true
      portMappings = [
        {
          containerPort = 443
          protocol      = "tcp"
        }
      ],
      dependsOn = [
        {
          containerName = "app"
          condition     = "START"
        }
      ],
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "${aws_cloudwatch_log_group.ecs_logs.name}"
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "web"
        }
      }
    }
  ])
}



data "aws_iam_policy" "aws_ecs_task_execution_policy" {
  name = "AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "execution-role" {
  name = "${var.ecs_cluster_name}-iam-role"

  assume_role_policy = jsonencode({
    "Version" : "2008-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ecs-tasks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_attachment" {
  role       = aws_iam_role.execution-role.name
  policy_arn = data.aws_iam_policy.aws_ecs_task_execution_policy.arn
}



resource "aws_ecs_service" "this" {
  name            = "${var.ecs_cluster_name}-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  launch_type     = "FARGATE"
  # desired_count   = 2

  network_configuration {
    subnets         = var.ecs_subnet_ids
    security_groups = [var.ecs-sg-id]
    # assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "web"
    container_port   = 443
  }

}

resource "aws_appautoscaling_target" "ecs_service" {
  max_capacity       = 5 # Set your desired max tasks
  min_capacity       = 2 # Set your desired min tasks
  resource_id        = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}


resource "aws_appautoscaling_policy" "cpu_utilization_policy" {
  name               = "cpu-utilization-scaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_service.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_service.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_service.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value       = 50.0 # Desired CPU utilization %
    scale_in_cooldown  = 60   # Wait time before scale-in
    scale_out_cooldown = 60   # Wait time before scale-out

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}
