# CloudFront Distribution
################################################################################################

resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name = aws_s3_bucket.bucket_static_web_subdomain.bucket_regional_domain_name
    origin_id   = "S3-${var.sub_domain}.${var.naked_domain}.${var.tld}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront Distribution for ${var.naked_domain}.${var.tld}"
  default_root_object = "index.html"

  aliases = [
    "${var.naked_domain}.${var.tld}",
    "${var.sub_domain}.${var.naked_domain}.${var.tld}"
  ]

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "S3-${var.sub_domain}.${var.naked_domain}.${var.tld}"
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

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.acm_certicate.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }

  tags = {
    Name = "CloudFront Distribution for ${var.naked_domain}.${var.tld}"
  }

  depends_on = [null_resource.upload_files]
}

# CloudFront Origin Access Identity
################################################################################################

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "${aws_s3_bucket.bucket_static_web_subdomain.bucket}-oac"
  description                       = "Origin access control for ${aws_s3_bucket.bucket_static_web_subdomain.bucket}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# CloudFront Origin Access Control
################################################################################################

resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for ${aws_s3_bucket.bucket_static_web_subdomain.bucket}"
}
