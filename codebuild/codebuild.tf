resource "aws_codebuild_project" "my_project" {
  name         = var.codebuild_project_name
  service_role = var.codebuild_role_arn

  artifacts {
    type = "CODEPIPELINE"
    name = "imagedefinitions.json"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "ACCOUNT_ID"
      value = var.aws_account_id
    }

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.aws_default_region
    }

    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = var.ecr_repository_name
    }

    environment_variable {
      name  = "REPOSITORY_URI"
      value = var.ecr_repository_url
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = var.codebuild_cloudwatch_log_group
      stream_name = var.codebuild-log-stream
    }

    s3_logs {
      status   = "ENABLED"
      location = "${var.s3_bucket_name}/build-log"
    }
  }

  source {
    type            = "CODEPIPELINE"
    buildspec       = "buildspec.yml"
    git_clone_depth = 1
  }
}
