variable "codebuild_role_name" {
  type        = string
  description = "Name of the CodeBuild IAM role"
}

variable "codebuild_policy_name" {
  type        = string
  description = "Name of the CodeBuild IAM policy"
}

variable "codebuild_policy_attachment_name" {
  type        = string
  description = "Legacy attachment identifier (kept for variable compatibility)"
}

variable "codepipeline_role_name" {
  type        = string
  description = "Name of the CodePipeline IAM role"
}

variable "codepipeline_policy_name" {
  type        = string
  description = "Name of the CodePipeline IAM policy"
}

variable "codepipeline_policy_attachment_name" {
  type        = string
  description = "Legacy attachment identifier (kept for variable compatibility)"
}

variable "ecs_quiz_app_task_execution_role_name" {
  type        = string
  description = "Name of the ECS Quiz App Task Execution Role"
}

variable "artifact_bucket_arn" {
  type        = string
  description = "ARN of the S3 bucket storing CodePipeline and CodeBuild artifacts"
}

variable "ecr_repository_arn" {
  type        = string
  description = "ARN of the target ECR repository"
}

variable "codestar_connection_arn" {
  type        = string
  description = "ARN of the CodeStar GitHub connection"
}

variable "aws_account_id" {
  type        = string
  description = "12-digit AWS account ID"
}

variable "aws_default_region" {
  type        = string
  description = "AWS deployment region"
}
