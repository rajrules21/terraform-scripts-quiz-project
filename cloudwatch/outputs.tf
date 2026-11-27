output "ecs_log_group_name" {
  value = aws_cloudwatch_log_group.quiz_app_log_group.name
}

output "ecs_log_group_arn" {
  value = aws_cloudwatch_log_group.quiz_app_log_group.arn
}

output "codebuild_log_group_name" {
  value = aws_cloudwatch_log_group.quiz_app_codebuild_log_group.name
}
