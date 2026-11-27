variable "vpc_id" {
  type        = string
  description = "VPC ID where security groups are created"
}

variable "alb_security_group_name" {
  type        = string
  description = "Name of the ALB security group"
}

variable "ecs_security_group_name" {
  type        = string
  description = "Name of the ECS security group"
}
