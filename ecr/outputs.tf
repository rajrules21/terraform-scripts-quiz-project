output "ecr_repository_name" {
  value = aws_ecr_repository.my_ecr_repo.name
}

output "ecr_repository_url" {
  value = aws_ecr_repository.my_ecr_repo.repository_url
}

output "ecr_repository_arn" {
  value = aws_ecr_repository.my_ecr_repo.arn
}
