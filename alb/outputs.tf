output "elb_id" {
  value = aws_lb.ecs_lb.id
}

output "alb_dns_name" {
  value = aws_lb.ecs_lb.dns_name
}

output "elb_target_group_arn" {
  value = aws_lb_target_group.ecs_target_group.arn
}

output "elb_listener" {
  value = aws_lb_listener.ecs_http_listener.arn
}
