variable "sns_topic_name" {
  type        = string
  description = "The name of the SNS topic to create"
}

variable "notification_email" {
  type        = string
  description = "Email address for pipeline and CloudWatch alarm SNS notifications"
}
