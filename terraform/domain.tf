# Import Route53 domain
################################################################################################

data "aws_route53_zone" "route53_domain" {
  name = "${var.naked_domain}.${var.tld}"
}

# Request public certificate
################################################################################################

resource "aws_acm_certificate" "acm_certicate" {
  domain_name       = "${var.naked_domain}.${var.tld}"
  validation_method = "DNS"

  subject_alternative_names = ["*.${var.naked_domain}.${var.tld}"]

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_route53_record" "route53_record" {
  for_each = {
    for dvo in aws_acm_certificate.acm_certicate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  allow_overwrite = true
  zone_id         = data.aws_route53_zone.route53_domain.zone_id
  name            = each.value.name
  type            = each.value.type
  ttl             = 300
  records         = [each.value.record]
}

# Validate certificate
################################################################################################

resource "aws_acm_certificate_validation" "validation" {
  certificate_arn         = aws_acm_certificate.acm_certicate.arn
  validation_record_fqdns = [for record in aws_route53_record.route53_record : record.fqdn]
}

# Create record naked route to cloudfront
################################################################################################

resource "aws_route53_record" "naked_route" {
  zone_id = data.aws_route53_zone.route53_domain.zone_id
  name    = "${var.naked_domain}.${var.tld}"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = false
  }
}

# Create record subdomain route to cloudfront
################################################################################################

resource "aws_route53_record" "subdomain_route" {
  zone_id = data.aws_route53_zone.route53_domain.zone_id
  name    = "${var.sub_domain}.${var.naked_domain}.${var.tld}"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = false
  }
}