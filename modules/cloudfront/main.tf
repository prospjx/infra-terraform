locals {
  s3_origin_id      = "s3-origin-${var.s3_bucket_id}"
  backend_origin_id = "eks-backend-origin"
}

resource "aws_cloudfront_origin_access_control" "myaccesscontrol" {
  name                              = "oac-${var.s3_bucket_id}"
  description                       = "Origin Access Control for S3 frontend"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "mydistribution" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Frontend CDN distribution"
  default_root_object = "index.html"

  origin {
    domain_name              = var.s3_bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.myaccesscontrol.id
    origin_id                = local.s3_origin_id
  }

  dynamic "origin" {
    for_each = var.backend_domain_name != "" ? [var.backend_domain_name] : []
    content {
      domain_name = origin.value
      origin_id   = local.backend_origin_id

      custom_origin_config {
        http_port                = 8000
        https_port               = 443
        origin_protocol_policy   = "http-only"
        origin_ssl_protocols     = ["TLSv1.2"]
        origin_read_timeout      = 60
        origin_keepalive_timeout = 5
      }
    }
  }

  dynamic "ordered_cache_behavior" {
    for_each = var.backend_domain_name != "" ? [1] : []
    content {
      path_pattern     = "/api/*"
      target_origin_id = local.backend_origin_id
      allowed_methods  = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
      cached_methods   = ["GET", "HEAD"]
      viewer_protocol_policy = "redirect-to-https"

      forwarded_values {
        query_string = true
        headers      = ["*"]
        cookies {
          forward = "all"
        }
      }

      min_ttl     = 0
      default_ttl = 0
      max_ttl     = 0
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = local.s3_origin_id
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  # SPA Routing: redirect 403 and 404 to index.html for client-side routing
  custom_error_response {
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
    error_caching_min_ttl = 10
  }

  custom_error_response {
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
    error_caching_min_ttl = 10
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Environment = "Dev"
    Project     = "SCSDev"
  }
}
