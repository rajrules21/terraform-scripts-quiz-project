# Common variables for both S3 and ECR

variable "ecr_repo_name" {
  type        = string
  description = "Name of the ECR repository to be created"
}
