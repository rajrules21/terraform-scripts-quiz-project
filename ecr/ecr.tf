# ECR Repository to hold CodeBuild Container Images

resource "aws_ecr_repository" "my_ecr_repo" {
  name         = var.ecr_repo_name
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }
}
