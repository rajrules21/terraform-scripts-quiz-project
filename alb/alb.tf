# Create Application Load Balancer for ECS service
resource "aws_lb" "ecs_lb" {
  name               = var.ecs_load_balancer
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = [var.alb_security_group_id]

  enable_deletion_protection = false

  tags = {
    Name = "ecs-lb"
  }
}

resource "aws_lb_target_group" "ecs_target_group" {
  name        = var.ecs_target_group
  port        = 5000 # Matches container port running Flask/Gunicorn
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb_listener" "ecs_http_listener" {
  load_balancer_arn = aws_lb.ecs_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_target_group.arn
  }
}
