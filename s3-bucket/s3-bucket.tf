provider "aws" {
  region = "us-west-2"  # Specify your AWS region
}

# Use the S3 bucket module to create a bucket
module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "my-s3-bucket"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}

# Define the bucket policy for public access
resource "aws_s3_bucket_policy" "public_access_policy" {
  bucket = module.s3_bucket.bucket

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${module.s3_bucket.arn}/*"
      }
    ]
  })
}

# Output the S3 bucket URL
output "s3_bucket_url" {
  value = "https://${module.s3_bucket.bucket}.s3.amazonaws.com/"
}