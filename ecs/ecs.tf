# AWS ECS Cluster
resource "aws_ecs_cluster" "my_ecs_cluster" {
  name = var.ecs_cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

# AWS ECS Task Definition
resource "aws_ecs_task_definition" "my_ecs_task_definition" {
  family                   = var.ecs_task_definition_name
  requires_compatibilities = [var.launch_type]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  task_role_arn            = var.execution_role_arn
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name      = var.ecr_repo_name
      image     = "${var.ecr_repository_url}:${var.image_tag}"
      cpu       = 512
      memory    = 1024
      essential = true
      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = var.log_group_name
          "awslogs-region"        = var.aws_default_region
          "awslogs-stream-prefix" = var.ecs_cloudwatch_log_stream
        }
      }
    }
  ])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

# AWS ECS Service
resource "aws_ecs_service" "my_ecs_service" {
  name                               = var.ecs_service_name
  cluster                            = aws_ecs_cluster.my_ecs_cluster.id
  task_definition                    = aws_ecs_task_definition.my_ecs_task_definition.arn
  desired_count                      = 1
  launch_type                        = var.launch_type
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  scheduling_strategy                = "REPLICA"

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = [var.ecs_security_group_id]
    # Production Hardening Note: Set to false when deploying in private subnets behind NAT Gateway
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.ecr_repo_name
    container_port   = 5000
  }

  health_check_grace_period_seconds = 300
}
