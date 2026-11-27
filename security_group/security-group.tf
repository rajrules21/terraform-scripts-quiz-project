# Create security group for ALB
resource "aws_security_group" "my_alb_security_group" {
  vpc_id = var.vpc_id
  name   = var.alb_security_group_name

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

# Create security group for ECS tasks (only accepts traffic from ALB on port 5000)
resource "aws_security_group" "my_ecs_security_group" {
  vpc_id = var.vpc_id
  name   = var.ecs_security_group_name

  ingress {
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.my_alb_security_group.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
