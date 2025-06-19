# infra/environments/prod/modules/cloudfront/main.tf

# cloudfront module
module "cdn" {
  source = "terraform-aws-modules/cloudfront/aws"

  aliases             = var.cloudfront_aliases
  comment             = var.cloudfront_comment
  enabled             = var.cloudfront_enabled
  is_ipv6_enabled     = var.cloudfront_is_ipv6_enabled
  price_class         = var.cloudfront_price_class
  retain_on_delete    = var.cloudfront_retain_on_delete
  wait_for_deployment = var.cloudfront_wait_for_deployment

  create_origin_access_identity = var.create_origin_access_identity

  origin_access_identities = {
    s3_bucket_one = var.origin_access_identity_description
  }

  origin = {
    s3_static = {
      domain_name = var.static_bucket_url
      s3_origin_config = {
        origin_access_identity = "s3_bucket_one"  
      }
    }
  }

  default_cache_behavior = {
    target_origin_id       = var.default_target_origin_id
    viewer_protocol_policy = var.default_viewer_protocol_policy

    allowed_methods = var.default_allowed_methods
    cached_methods  = var.default_cached_methods
    compress        = var.default_compress
    query_string    = var.default_query_string
  }

  ordered_cache_behavior = [
    {
      path_pattern           = var.static_path_pattern
      target_origin_id       = var.static_target_origin_id
      viewer_protocol_policy = var.static_viewer_protocol_policy

      allowed_methods = var.static_allowed_methods
      cached_methods  = var.static_cached_methods
      compress        = var.static_compress
      query_string    = var.static_query_string
    }
  ]

  viewer_certificate = {
    acm_certificate_arn = var.viewer_certificate_arn
    ssl_support_method  = var.ssl_support_method
  }

  tags = var.tags
}
