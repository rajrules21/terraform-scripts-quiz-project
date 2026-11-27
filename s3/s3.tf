##########################################################################################################################

#S3 bucket to hold artifacts

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name

  force_destroy = true

  tags = {
    Name        = "Usage"
    Environment = "Artifacts"
  }
}

resource "aws_s3_bucket_ownership_controls" "bucket_owner" {
  bucket = aws_s3_bucket.my_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "disable_public_access" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.bucket_owner,
    aws_s3_bucket_public_access_block.disable_public_access,
  ]

  bucket = aws_s3_bucket.my_bucket.id
  acl    = "private"
}



