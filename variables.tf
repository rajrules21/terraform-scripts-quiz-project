# Root Input Variables

variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket to be created for pipeline artifacts"
}

variable "ecr_repo_name" {
  type        = string
  description = "Name of the ECR repository to be created"
}

variable "ecs_cluster_name" {
  type        = string
  description = "Name of the ECS cluster to be created"
}

variable "ecs_task_definition_name" {
  type        = string
  description = "Name of Task Definition Family"
}

variable "ecs_service_name" {
  type        = string
  description = "Name of the ECS Service"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "subnet_1_cidr_block" {
  type        = string
  description = "CIDR block for subnet 1"
}

variable "subnet_2_cidr_block" {
  type        = string
  description = "CIDR block for subnet 2"
}

variable "subnet_1_availability_zone" {
  type        = string
  description = "Availability zone for subnet 1"
}

variable "subnet_2_availability_zone" {
  type        = string
  description = "Availability zone for subnet 2"
}

variable "alb_security_group_name" {
  type        = string
  description = "Name of the ALB security group"
}

variable "ecs_security_group_name" {
  type        = string
  description = "Name of the ECS security group"
}

variable "ecs_load_balancer" {
  type        = string
  description = "Name of the ECS Load Balancer"
}

variable "ecs_target_group" {
  type        = string
  description = "Name of the ECS Target Group"
}

variable "aws_account_id" {
  type        = string
  description = "12-digit AWS Account ID"
}

variable "github_repo_name" {
  type        = string
  description = "GitHub Repository Name (owner/repo)"
}

variable "image_tag" {
  type        = string
  description = "Docker image tag"
  default     = "latest"
}

variable "ecs_cloudwatch_log_group" {
  type        = string
  description = "Name of the ECS CloudWatch log group"
}

variable "aws_default_region" {
  type        = string
  description = "AWS Region"
  default     = "ap-south-1"
}

variable "launch_type" {
  type        = string
  description = "ECS Launch type"
  default     = "FARGATE"
}

variable "codebuild_cloudwatch_log_group" {
  type        = string
  description = "Name of the CodeBuild CloudWatch log group"
}

variable "codebuild-log-stream" {
  type        = string
  description = "Name of the CodeBuild CloudWatch log stream"
}

variable "codebuild_project_name" {
  type        = string
  description = "Name of the CodeBuild project"
}

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
  description = "Name of the CodeBuild IAM policy attachment"
}

variable "codepipeline_pipeline_name" {
  type        = string
  description = "Name of the CodePipeline pipeline"
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
  description = "Name of the CodePipeline IAM policy attachment"
}

variable "ecs_cloudwatch_log_stream" {
  type        = string
  description = "Name of the ECS CloudWatch log stream"
}

variable "ecs_quiz_app_task_execution_role_name" {
  type        = string
  description = "Name of the ECS Task Execution Role"
}

variable "aws_codestarconnections_connection_name" {
  type        = string
  description = "Name of the CodeStar Connection"
}

variable "aws_codestar_provider_type" {
  type        = string
  description = "Type of the CodeStar provider"
  default     = "GitHub"
}

variable "cloudwatch_dashboard_name" {
  type        = string
  description = "Name of the CloudWatch dashboard"
}

variable "ecs_memory_utilization" {
  type        = string
  description = "Name of the CloudWatch ECS memory alarm"
}

variable "ecs_cpu_utilization" {
  type        = string
  description = "Name of the CloudWatch ECS CPU alarm"
}

variable "ecs_network_utilization" {
  type        = string
  description = "Name of the CloudWatch ECS network alarm"
}

variable "sns_topic_name" {
  type        = string
  description = "Name of the SNS notification topic"
}

variable "codepipeline_notification_rule" {
  type        = string
  description = "Name of the CodePipeline notification rule"
}

variable "notification_email" {
  type        = string
  description = "Optional email endpoint for SNS alerts (leave empty to skip subscription)"
  default     = ""
}
