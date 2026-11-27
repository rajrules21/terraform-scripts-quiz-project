variable "codebuild_project_name" {
  type        = string
  description = "Name of the CodeBuild project"
}

variable "codebuild_role_arn" {
  type        = string
  description = "IAM role ARN used by CodeBuild"
}

variable "codebuild_cloudwatch_log_group" {
  type        = string
  description = "Name of the CloudWatch log group for CodeBuild"
}

variable "codebuild-log-stream" {
  type        = string
  description = "Name of the CloudWatch log stream"
}

variable "aws_account_id" {
  type        = string
  description = "12-digit AWS account ID"
}

variable "aws_default_region" {
  type        = string
  description = "AWS deployment region"
}

variable "ecr_repository_name" {
  type        = string
  description = "Name of the target ECR repository"
}

variable "ecr_repository_url" {
  type        = string
  description = "URL of the target ECR repository"
}

variable "s3_bucket_name" {
  type        = string
  description = "S3 bucket name for CodeBuild logs"
}
