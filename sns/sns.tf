# Create SNS Topic for CodePipeline & CloudWatch Alerts
resource "aws_sns_topic" "my_topic" {
  name       = var.sns_topic_name
  fifo_topic = false
}

resource "aws_sns_topic_policy" "default" {
  arn = aws_sns_topic.my_topic.arn

  policy = jsonencode({
    Version = "2008-10-17"
    Statement = [
      {
        Sid       = "CodeNotification_publish"
        Effect    = "Allow"
        Principal = { Service = "codestar-notifications.amazonaws.com" }
        Action    = "SNS:Publish"
        Resource  = aws_sns_topic.my_topic.arn
      }
    ]
  })
}

# Email subscription (requires confirmation link click after apply)
resource "aws_sns_topic_subscription" "email_subscription" {
  count     = var.notification_email != "" ? 1 : 0
  topic_arn = aws_sns_topic.my_topic.arn
  protocol  = "email"
  endpoint  = var.notification_email
}
