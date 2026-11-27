variable "codepipeline_pipeline_name" {
  type        = string
  description = "Name of the CodePipeline pipeline"
}

variable "github_repo_name" {
  type        = string
  description = "GitHub repository in owner/repo format"
}

variable "branch_name" {
  type        = string
  description = "Source Git branch monitored by CodePipeline"
  default     = "main"
}

variable "codepipeline_role_arn" {
  type        = string
  description = "IAM role ARN used by CodePipeline"
}

variable "artifact_bucket_name" {
  type        = string
  description = "S3 bucket name for CodePipeline artifacts"
}

variable "codestar_connection_arn" {
  type        = string
  description = "CodeStar Connection ARN for GitHub source integration"
}

variable "codebuild_project_name" {
  type        = string
  description = "CodeBuild project name used in the Build stage"
}

variable "ecs_cluster_name" {
  type        = string
  description = "Target ECS cluster name for deployment"
}

variable "ecs_service_name" {
  type        = string
  description = "Target ECS service name for deployment"
}

variable "sns_topic_arn" {
  type        = string
  description = "SNS topic ARN for pipeline status notifications"
}

variable "codepipeline_notification_rule" {
  type        = string
  description = "Name of the CodeStar notification rule"
}
