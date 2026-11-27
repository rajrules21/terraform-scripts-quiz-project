# Common variables for both S3 and ECR

variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket to be created"
}
