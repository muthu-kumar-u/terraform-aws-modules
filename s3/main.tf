# infra/environments/prod/modules/s3/main.tf

# s3 module
module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"

  bucket = var.bucket_name
  acl    = var.acl_mode

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
  policy = jsonencode({
    "Version": "2008-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Sid": "AllowCloudFrontServicePrincipal",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudfront.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.bucket_name}/*",
            "Condition": {
                "StringEquals": {
                    "AWS:SourceArn": var.cloudfront_arn
                }
            }
        }
    ]
})

  versioning = {
    enabled = var.enable_versioning
  }

  server_side_encryption_configuration = {
    rule = {
      bucket_key_enabled = var.bucket_key_enabled
    }
  }

  object_lock_enabled = var.object_lock_enabled

  tags = var.tags
}
