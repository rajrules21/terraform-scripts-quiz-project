output "codebuild_project_name" {
  value = aws_codebuild_project.my_project.name
}

output "codebuild_project_arn" {
  value = aws_codebuild_project.my_project.arn
}
