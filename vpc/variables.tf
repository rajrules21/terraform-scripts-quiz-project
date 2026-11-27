# Common variables for both S3 and ECR
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
