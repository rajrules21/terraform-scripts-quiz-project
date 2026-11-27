# CloudWatch Log Group for ECS Container Logs
resource "aws_cloudwatch_log_group" "quiz_app_log_group" {
  name              = var.ecs_cloudwatch_log_group
  retention_in_days = 7

  tags = {
    Environment = "production"
    Application = "ECS Quiz App"
  }
}

# CloudWatch Log Group for CodeBuild Project Logs
resource "aws_cloudwatch_log_group" "quiz_app_codebuild_log_group" {
  name              = var.codebuild_cloudwatch_log_group
  retention_in_days = 7

  tags = {
    Project = "quiz-app"
    Type    = "codebuild-logs"
  }
}

# CloudWatch Alarm for ECS Memory Utilization
resource "aws_cloudwatch_metric_alarm" "ecs_memory_utilization" {
  alarm_name          = var.ecs_memory_utilization
  alarm_description   = "Memory Utilization for ECS Cluster"
  actions_enabled     = true
  alarm_actions       = [var.sns_topic_arn]
  namespace           = "ECS/ContainerInsights"
  metric_name         = "MemoryUtilized"
  statistic           = "Average"
  period              = 300
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  threshold           = 85
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "missing"

  dimensions = {
    ClusterName = var.ecs_cluster_name
  }
}

# CloudWatch Alarm for ECS CPU Utilization
resource "aws_cloudwatch_metric_alarm" "ecs_cpu_utilization" {
  alarm_name          = var.ecs_cpu_utilization
  alarm_description   = "CPU Utilization for ECS Cluster"
  actions_enabled     = true
  alarm_actions       = [var.sns_topic_arn]
  namespace           = "AWS/ECS"
  metric_name         = "CPUUtilization"
  statistic           = "Average"
  period              = 300
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  threshold           = 85
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "missing"

  dimensions = {
    ClusterName = var.ecs_cluster_name
  }
}

# CloudWatch Alarm for ECS Network Utilization
resource "aws_cloudwatch_metric_alarm" "ecs_network_utilization" {
  alarm_name          = var.ecs_network_utilization
  alarm_description   = "Network Utilization for ECS Cluster"
  actions_enabled     = true
  alarm_actions       = [var.sns_topic_arn]
  namespace           = "AWS/ECS"
  metric_name         = "NetworkOut"
  statistic           = "Average"
  period              = 300
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  threshold           = 85
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "missing"

  dimensions = {
    ClusterName = var.ecs_cluster_name
  }
}

# CloudWatch Dashboard for ECS Container Insights
resource "aws_cloudwatch_dashboard" "cw_dashboard" {
  dashboard_name = var.cloudwatch_dashboard_name

  dashboard_body = jsonencode({
    widgets = [
      {
        height = 6, width = 6, y = 0, x = 0, type = "metric",
        properties = {
          region = var.aws_default_region, title = "CPU utilization",
          legend = { position = "bottom" }, timezone = "LOCAL",
          metrics = [
            [{ id = "expr1m0", label = var.ecs_cluster_name, expression = "mm1m0 * 100 / mm0m0", stat = "Average" }],
            ["ECS/ContainerInsights", "CpuReserved", "ClusterName", var.ecs_cluster_name, { id = "mm0m0", visible = false, stat = "Sum" }],
            [".", "CpuUtilized", ".", ".", { id = "mm1m0", visible = false, stat = "Sum" }]
          ],
          liveData = true, period = 60,
          yAxis    = { left = { min = 0, showUnits = false, label = "Percent" } }
        }
      },
      {
        height = 6, width = 6, y = 0, x = 6, type = "metric",
        properties = {
          region = var.aws_default_region, title = "Memory utilization",
          legend = { position = "bottom" }, timezone = "LOCAL",
          metrics = [
            [{ id = "expr1m0", label = var.ecs_cluster_name, expression = "mm1m0 * 100 / mm0m0", stat = "Average" }],
            ["ECS/ContainerInsights", "MemoryReserved", "ClusterName", var.ecs_cluster_name, { id = "mm0m0", visible = false, stat = "Sum" }],
            [".", "MemoryUtilized", ".", ".", { id = "mm1m0", visible = false, stat = "Sum" }]
          ],
          liveData = true, period = 60,
          yAxis    = { left = { min = 0, showUnits = false, label = "Percent" } }
        }
      },
      {
        type = "alarm", x = 14, y = 6, width = 10, height = 3,
        properties = {
          title  = "ECS-MEMORY-UTILIZATION-ALARM",
          alarms = [aws_cloudwatch_metric_alarm.ecs_memory_utilization.arn]
        }
      },
      {
        type = "alarm", x = 14, y = 9, width = 10, height = 3,
        properties = {
          title  = "ECS-CPU-UTILIZATION-ALARM",
          alarms = [aws_cloudwatch_metric_alarm.ecs_cpu_utilization.arn]
        }
      }
    ]
  })
}
