# Terraform Root Orchestrator Module

# 1. S3 Artifact Storage
module "s3" {
  source      = "./s3"
  bucket_name = var.bucket_name
}

# 2. VPC & Subnet Networking
module "vpc" {
  source                     = "./vpc"
  vpc_cidr_block             = var.vpc_cidr_block
  subnet_1_cidr_block        = var.subnet_1_cidr_block
  subnet_1_availability_zone = var.subnet_1_availability_zone
  subnet_2_cidr_block        = var.subnet_2_cidr_block
  subnet_2_availability_zone = var.subnet_2_availability_zone
}

# 3. Security Groups (ALB & ECS Fargate)
module "security_group" {
  source                  = "./security_group"
  vpc_id                  = module.vpc.vpc_id
  alb_security_group_name = var.alb_security_group_name
  ecs_security_group_name = var.ecs_security_group_name
}

# 4. Amazon ECR Registry
module "ecr" {
  source        = "./ecr"
  ecr_repo_name = var.ecr_repo_name
}

# 5. SNS Alerting Topic
module "sns" {
  source             = "./sns"
  sns_topic_name     = var.sns_topic_name
  notification_email = var.notification_email
}

# 6. Application Load Balancer
module "alb" {
  source                = "./alb"
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.subnet_ids
  alb_security_group_id = module.security_group.alb_security_group_id
  ecs_load_balancer     = var.ecs_load_balancer
  ecs_target_group      = var.ecs_target_group
}

# 7. IAM Roles & Policies
module "iam" {
  source                                = "./iam"
  codebuild_role_name                   = var.codebuild_role_name
  codebuild_policy_name                 = var.codebuild_policy_name
  codebuild_policy_attachment_name      = var.codebuild_policy_attachment_name
  codepipeline_role_name                = var.codepipeline_role_name
  codepipeline_policy_name              = var.codepipeline_policy_name
  codepipeline_policy_attachment_name   = var.codepipeline_policy_attachment_name
  ecs_quiz_app_task_execution_role_name = var.ecs_quiz_app_task_execution_role_name
  artifact_bucket_arn                   = module.s3.bucket_arn
  ecr_repository_arn                    = module.ecr.ecr_repository_arn
  codestar_connection_arn               = aws_codestarconnections_connection.github-connection.arn
  aws_account_id                        = var.aws_account_id
  aws_default_region                    = var.aws_default_region
}

# 8. CloudWatch Observability & Alarms
module "cloudwatch" {
  source                         = "./cloudwatch"
  ecs_cloudwatch_log_group       = var.ecs_cloudwatch_log_group
  codebuild_cloudwatch_log_group = var.codebuild_cloudwatch_log_group
  ecs_memory_utilization         = var.ecs_memory_utilization
  ecs_cpu_utilization            = var.ecs_cpu_utilization
  ecs_network_utilization        = var.ecs_network_utilization
  ecs_cluster_name               = var.ecs_cluster_name
  sns_topic_arn                  = module.sns.aws_sns_topic_arn
  cloudwatch_dashboard_name      = var.cloudwatch_dashboard_name
  aws_default_region             = var.aws_default_region
}

# 9. AWS ECS Fargate Cluster & Service
module "ecs" {
  source                    = "./ecs"
  ecs_cluster_name          = var.ecs_cluster_name
  ecs_task_definition_name  = var.ecs_task_definition_name
  ecs_service_name          = var.ecs_service_name
  launch_type               = var.launch_type
  image_tag                 = var.image_tag
  ecr_repo_name             = var.ecr_repo_name
  ecr_repository_url        = module.ecr.ecr_repository_url
  execution_role_arn        = module.iam.ecs_task_execution_role_arn
  log_group_name            = module.cloudwatch.ecs_log_group_name
  aws_default_region        = var.aws_default_region
  ecs_cloudwatch_log_stream = var.ecs_cloudwatch_log_stream
  subnet_ids                = module.vpc.subnet_ids
  ecs_security_group_id     = module.security_group.ecs_security_group_id
  target_group_arn          = module.alb.elb_target_group_arn
}

# 10. AWS CodeBuild Project
module "codebuild" {
  source                         = "./codebuild"
  codebuild_project_name         = var.codebuild_project_name
  codebuild_role_arn             = module.iam.codebuild_role_arn
  codebuild_cloudwatch_log_group = module.cloudwatch.codebuild_log_group_name
  codebuild-log-stream           = var.codebuild-log-stream
  aws_account_id                 = var.aws_account_id
  aws_default_region             = var.aws_default_region
  ecr_repository_name            = module.ecr.ecr_repository_name
  ecr_repository_url             = module.ecr.ecr_repository_url
  s3_bucket_name                 = module.s3.bucket_name
}

# 11. AWS CodePipeline CI/CD
module "codepipeline" {
  source                         = "./codepipeline"
  codepipeline_pipeline_name     = var.codepipeline_pipeline_name
  github_repo_name               = var.github_repo_name
  codepipeline_role_arn          = module.iam.codepipeline_role_arn
  artifact_bucket_name           = module.s3.bucket_name
  codestar_connection_arn        = aws_codestarconnections_connection.github-connection.arn
  codebuild_project_name         = module.codebuild.codebuild_project_name
  ecs_cluster_name               = module.ecs.ecs_cluster_name
  ecs_service_name               = module.ecs.ecs_service_name
  sns_topic_arn                  = module.sns.aws_sns_topic_arn
  codepipeline_notification_rule = var.codepipeline_notification_rule
}
