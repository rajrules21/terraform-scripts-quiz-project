
output "alb_security_group_id" {
  value = aws_security_group.my_alb_security_group.id
}

output "ecs_security_group_id" {
  value = aws_security_group.my_ecs_security_group.id
}




