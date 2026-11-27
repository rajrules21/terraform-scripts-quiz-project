variable "vpc_id" {
  type        = string
  description = "VPC ID for the ALB target group"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the Application Load Balancer"
}

variable "alb_security_group_id" {
  type        = string
  description = "Security group ID attached to the ALB"
}

variable "ecs_load_balancer" {
  type        = string
  description = "Name of the ECS Load Balancer"
}

variable "ecs_target_group" {
  type        = string
  description = "Name of the ECS Target Group"
}
